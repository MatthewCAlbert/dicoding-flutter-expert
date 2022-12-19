import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovie;

  final movieModelTest = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final movieListTest = <Movie>[movieModelTest];
  const queryTest = 'spiderman';

  setUp(() {
    mockSearchMovie = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(mockSearchMovie);
  });

  group('Search movie with bloc', () {
    test('initial state should be empty', () {
      expect(movieSearchBloc.state, SearchEmpty());
    });

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [Loading, HasData] when search Movie data is successfully',
      build: () {
        when(mockSearchMovie.execute(queryTest))
            .thenAnswer((_) async => Right(movieListTest));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasMovieData(movieListTest),
      ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(queryTest));
      },
    );

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [Loading, Error] when get movie search is unsuccessful',
      build: () {
        when(mockSearchMovie.execute(queryTest))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(queryTest));
      },
    );
  });
}
