import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailTVSeriesBloc fakeDetailTVSeriesBloc;
  late FakeRecommendationTVSeriesBloc fakeRecommendationTVSeriesBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;

  setUp(() {
    fakeDetailTVSeriesBloc = FakeDetailTVSeriesBloc();
    registerFallbackValue(FakeDetailTVSeriesEvent());
    registerFallbackValue(FakeDetailTVSeriesState());
    fakeRecommendationTVSeriesBloc = FakeRecommendationTVSeriesBloc();
    registerFallbackValue(FakeRecommendationTVSeriesEvent());
    registerFallbackValue(FakeRecommendationTVSeriesState());
    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());
  });

  tearDown(() {
    fakeDetailTVSeriesBloc.close();
    fakeRecommendationTVSeriesBloc.close();
    fakeWatchlistTVSeriesBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (context) => fakeDetailTVSeriesBloc,
        ),
        BlocProvider<RecommendationTVSeriesBloc>(
          create: (context) => fakeRecommendationTVSeriesBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (context) => fakeWatchlistTVSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const idTest = 1;

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(TVSeriesDetailLoading());
    when(() => fakeRecommendationTVSeriesBloc.state)
        .thenReturn(TVSeriesRecommendationLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailTVSeriesBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeRecommendationTVSeriesBloc.state)
        .thenReturn(TVSeriesRecommendationHasData(testTvSeriesList));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesHasList(testTvSeriesList));
    await tester
        .pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });
}
