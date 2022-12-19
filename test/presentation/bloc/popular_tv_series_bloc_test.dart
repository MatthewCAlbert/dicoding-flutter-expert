import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTVSeriesBloc popularTVSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularTVSeriesBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  final tvList = <TvSeries>[];

  test("PopularTVSeriesBloc initial state should be empty", () {
    expect(popularTVSeriesBloc.state, PopularTVSeriesEmpty());
  });

  group('Popular TV series test', () {
    blocTest<PopularTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, HasData] when popular TV series data is fetched successfully',
        build: () {
          when(mockGetPopularTVSeries.execute())
              .thenAnswer((_) async => Right(tvList));
          return popularTVSeriesBloc;
        },
        act: (bloc) => bloc.add(PopularTVSeries()),
        expect: () =>
            [PopularTVSeriesLoading(), PopularTVSeriesHasData(tvList)],
        verify: (bloc) {
          verify(mockGetPopularTVSeries.execute());
        });

    blocTest<PopularTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, Error] when popular TV series data is failed to fetch',
        build: () {
          when(mockGetPopularTVSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularTVSeriesBloc;
        },
        act: (bloc) => bloc.add(PopularTVSeries()),
        expect: () => [
              PopularTVSeriesLoading(),
              const PopularTVSeriesError('Server Failure')
            ],
        verify: (bloc) {
          verify(mockGetPopularTVSeries.execute());
        });
  });
}
