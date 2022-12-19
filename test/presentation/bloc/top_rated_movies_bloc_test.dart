import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovie;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  final movieList = <Movie>[];

  test("TopRatedMovieBloc initial state should be empty", () {
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  group(
    'Top rated movie test',
    () {
      blocTest<TopRatedMovieBloc, MovieState>(
        'Should emit [Loading, HasData] when top rated movie data is fetched successfully',
        build: () {
          when(mockGetTopRatedMovie.execute())
              .thenAnswer((_) async => Right(movieList));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(TopRatedMovie()),
        expect: () => [TopRatedMovieLoading(), TopRatedMovieHasData(movieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovie.execute());
        },
      );

      blocTest<TopRatedMovieBloc, MovieState>(
        'Should emit [Loading, Error] when get top rated movie data is failed to fetched',
        build: () {
          when(mockGetTopRatedMovie.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(TopRatedMovie()),
        expect: () => [
          TopRatedMovieLoading(),
          const TopRatedMovieError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovie.execute());
        },
      );
    },
  );
}
