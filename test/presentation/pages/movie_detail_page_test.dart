import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailTVSeriesBloc fakeDetailTvBloc;
  late FakeRecommendationTVSeriesBloc fakeRecommendationTvBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTvBloc;

  setUp(() {
    fakeDetailTvBloc = FakeDetailTVSeriesBloc();
    registerFallbackValue(FakeDetailTVSeriesEvent());
    registerFallbackValue(FakeDetailTVSeriesState());
    fakeRecommendationTvBloc = FakeRecommendationTVSeriesBloc();
    registerFallbackValue(FakeRecommendationTVSeriesEvent());
    registerFallbackValue(FakeRecommendationTVSeriesState());
    fakeWatchlistTvBloc = FakeWatchlistTVSeriesBloc();
    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());
  });

  tearDown(() {
    fakeDetailTvBloc.close();
    fakeRecommendationTvBloc.close();
    fakeWatchlistTvBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (context) => fakeDetailTvBloc,
        ),
        BlocProvider<RecommendationTVSeriesBloc>(
          create: (context) => fakeRecommendationTvBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (context) => fakeWatchlistTvBloc,
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
    when(() => fakeDetailTvBloc.state).thenReturn(TVSeriesDetailLoading());
    when(() => fakeRecommendationTvBloc.state)
        .thenReturn(TVSeriesRecommendationLoading());
    when(() => fakeWatchlistTvBloc.state)
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
    when(() => fakeDetailTvBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeRecommendationTvBloc.state)
        .thenReturn(TVSeriesRecommendationHasData(testTvSeriesList));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTVSeriesHasList(testTvSeriesList));
    await tester
        .pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });
}
