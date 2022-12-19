import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovie;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovie);
  });

  test('NowPlayingMovieBloc initial state should be empty ', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieEmpty());
  });

  group('Now playing movie test', () {
    blocTest<NowPlayingMovieBloc, MovieState>(
        'should emits [Loading, HasData] when data is successfully fetched.',
        build: () {
          when(mockGetNowPlayingMovie.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return nowPlayingMovieBloc;
        },
        act: (bloc) => bloc.add(NowPlayingMovie()),
        expect: () => <MovieState>[
              NowPlayingMovieLoading(),
              NowPlayingMovieHasData(testMovieList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovie.execute());
          return NowPlayingMovie().props;
        });

    blocTest<NowPlayingMovieBloc, MovieState>(
      'should emits [Loading, Error] when now playing movie data is failed to fetch',
      build: () {
        when(mockGetNowPlayingMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(NowPlayingMovie()),
      expect: () => <MovieState>[
        NowPlayingMovieLoading(),
        const NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingMovieLoading(),
    );
  });
}
