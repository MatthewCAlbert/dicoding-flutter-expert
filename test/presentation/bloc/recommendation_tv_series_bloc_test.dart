import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationTVSeriesBloc recommendationTVSeriesBloc;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;

  setUp(() {
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    recommendationTVSeriesBloc =
        RecommendationTVSeriesBloc(mockGetTVSeriesRecommendations);
  });

  const idTest = 1;
  final tvTest = <TvSeries>[];

  test("RecommendationTVSeriesBloc initial state should be empty", () {
    expect(recommendationTVSeriesBloc.state, TVSeriesRecommendationEmpty());
  });

  group(
    'Recommendation TV series Test',
    () {
      blocTest<RecommendationTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, HasData] when recommendation TV series data is fetched successfully',
        build: () {
          when(mockGetTVSeriesRecommendations.execute(idTest))
              .thenAnswer((_) async => Right(tvTest));
          return recommendationTVSeriesBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTVSeries(idTest)),
        expect: () => [
          TVSeriesRecommendationLoading(),
          TVSeriesRecommendationHasData(tvTest)
        ],
        verify: (bloc) {
          verify(mockGetTVSeriesRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, Error] when get recommendation TV series data is failed to fetch',
        build: () {
          when(mockGetTVSeriesRecommendations.execute(idTest))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return recommendationTVSeriesBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTVSeries(idTest)),
        expect: () => [
          TVSeriesRecommendationLoading(),
          const TVSeriesRecommendationError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTVSeriesRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationTVSeriesBloc, TVSeriesState>(
        'should emits [Loading, Empty] when recommendation TV series data is empty',
        build: () {
          when(mockGetTVSeriesRecommendations.execute(idTest))
              .thenAnswer((_) async => const Right([]));
          return recommendationTVSeriesBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTVSeries(idTest)),
        expect: () => <TVSeriesState>[
          TVSeriesRecommendationLoading(),
          const TVSeriesRecommendationHasData([]),
        ],
      );
    },
  );
}
