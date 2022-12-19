import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeMovieSearchBloc fakeMovieSearchBloc;

  setUp(() {
    fakeMovieSearchBloc = FakeMovieSearchBloc();
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
  });

  tearDown(() {
    fakeMovieSearchBloc.close();
  });

  final testMovieList = [testMovie];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>(
      create: (_) => fakeMovieSearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieSearchBloc.state).thenReturn(SearchLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
    'should display data when data is fetched successfully',
    (WidgetTester tester) async {
      when(() => fakeMovieSearchBloc.state)
          .thenReturn(SearchHasMovieData(testMovieList));
      await tester.pumpWidget(_makeTestableWidget(SearchPage()));
      await tester.pump();
    },
  );
}
