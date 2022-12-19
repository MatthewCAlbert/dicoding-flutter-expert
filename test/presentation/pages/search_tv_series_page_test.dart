import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeTVSeriesSearchBloc faketTVSeriesSearchBloc;

  setUp(() {
    faketTVSeriesSearchBloc = FakeTVSeriesSearchBloc();
    registerFallbackValue(FakeTVSeriesSearchEvent());
    registerFallbackValue(FakeTVSeriesSearchState());
  });

  tearDown(() {
    faketTVSeriesSearchBloc.close();
  });

  final tVSeriesTestList = [testTvSeries];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesSearchBloc>(
      create: (_) => faketTVSeriesSearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => faketTVSeriesSearchBloc.state).thenReturn(SearchLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
    'should display data when data is fetched successfully',
    (WidgetTester tester) async {
      when(() => faketTVSeriesSearchBloc.state)
          .thenReturn(SearchHasTvSeriesData(tVSeriesTestList));
      await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));
      await tester.pump();
    },
  );
}
