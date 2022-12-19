import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/airing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeOnTheAirTVSeriesBloc fakeAiringTVBloc;

  setUp(() {
    fakeAiringTVBloc = FakeOnTheAirTVSeriesBloc();
    registerFallbackValue(FakeOnTheAirTVSeriesEvent());
    registerFallbackValue(FakeOnTheAirTVSeriesState());
  });

  tearDown(() {
    fakeAiringTVBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTVSeriesBloc>(
      create: (_) => fakeAiringTVBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeAiringTVBloc.state).thenReturn(OnTheAirTVSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(AiringTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeAiringTVBloc.state)
        .thenReturn(OnTheAirTVSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(AiringTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
