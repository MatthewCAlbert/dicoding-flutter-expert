import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesSearchBloc tvSearchBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  final tvModelTest = TvSeries(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the DAmelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 29.21,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9,
    voteCount: 3145,
  );

  final tvListTest = <TvSeries>[tvModelTest];
  const queryTest = 'amelio';

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    tvSearchBloc = TVSeriesSearchBloc(mockSearchTVSeries);
  });

  group('Search TV series with bloc', () {
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, SearchEmpty());
    });

    blocTest<TVSeriesSearchBloc, SearchState>(
      'Should emit [Loading, HasData] when search TV series data is successfully',
      build: () {
        when(mockSearchTVSeries.execute(queryTest))
            .thenAnswer((_) async => Right(tvListTest));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasTvSeriesData(tvListTest),
      ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(queryTest));
      },
    );

    blocTest<TVSeriesSearchBloc, SearchState>(
      'Should emit [Loading, Error] when get TV series search is unsuccessful',
      build: () {
        when(mockSearchTVSeries.execute(queryTest))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(queryTest));
      },
    );
  });
}
