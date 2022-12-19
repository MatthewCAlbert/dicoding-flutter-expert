import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  const idTest = 1;

  test("DetailMovieBloc initial state should be empty", () {
    expect(detailMovieBloc.state, MovieDetailEmpty());
  });

  group('Detail movie test', () {
    blocTest<DetailMovieBloc, MovieState>(
      'Should emit [Loading, HasData] when movie detail data is fetched successfully',
      build: () {
        when(mockGetMovieDetail.execute(idTest))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const DetailMovie(idTest)),
      expect: () => [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(idTest));
      },
    );

    blocTest<DetailMovieBloc, MovieState>(
      'Should emit [Loading, Error] when detail movie data is failed to fetched',
      build: () {
        when(mockGetMovieDetail.execute(idTest))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const DetailMovie(idTest)),
      expect: () =>
          [MovieDetailLoading(), const MovieDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(idTest));
      },
    );
  });
}
