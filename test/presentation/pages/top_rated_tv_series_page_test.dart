import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeTopRatedTVSeriesBloc fakeTopRatedTVSeriesBloc;

  setUp(() {
    fakeTopRatedTVSeriesBloc = FakeTopRatedTVSeriesBloc();
    registerFallbackValue(FakeTopRatedTVSeriesEvent());
    registerFallbackValue(FakeTopRatedTVSeriesState());
  });

  tearDown(() {
    fakeTopRatedTVSeriesBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>(
      create: (_) => fakeTopRatedTVSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
