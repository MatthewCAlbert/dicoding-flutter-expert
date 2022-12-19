import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationmendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationmendationMovieBloc(mockGetMovieRecommendations);
  });

  const idTest = 1;
  final movieTest = <Movie>[];

  test("RecommendationMovieBloc initial state should be empty", () {
    expect(recommendationMovieBloc.state, MovieRecommendationEmpty());
  });

  group(
    'Recommendation movie Test',
    () {
      blocTest<RecommendationmendationMovieBloc, MovieState>(
        'Should emit [Loading, HasData] when recommendation movie data is fetched successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => Right(movieTest));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationHasData(movieTest)
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationmendationMovieBloc, MovieState>(
        'Should emit [Loading, Error] when get recommendation movie data is failed to fetch',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () => [
          MovieRecommendationLoading(),
          const MovieRecommendationError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationmendationMovieBloc, MovieState>(
        'should emits [Loading, Empty] when recommendation movie data is empty',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => const Right([]));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () => <MovieState>[
          MovieRecommendationLoading(),
          const MovieRecommendationHasData([]),
        ],
      );
    },
  );
}
