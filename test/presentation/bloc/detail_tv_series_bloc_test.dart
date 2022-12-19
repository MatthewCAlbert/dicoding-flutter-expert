import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesDetailBloc detailTVSeriesBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    detailTVSeriesBloc = TVSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  const idTest = 1;
  test("DetailTVSeriesBloc initial state should be empty", () {
    expect(detailTVSeriesBloc.state, TVSeriesDetailEmpty());
  });

  group('Detail TVSeries test', () {
    blocTest<TVSeriesDetailBloc, TVSeriesState>(
      'Should emit [Loading, HasData] when TV series detail data is fetched successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(idTest))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTVSeries(idTest)),
      expect: () =>
          [TVSeriesDetailLoading(), TVSeriesDetailHasData(testTvSeriesDetail)],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(idTest));
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesState>(
      'Should emit [Loading, Error] when detail TVSeries data is failed to fetch',
      build: () {
        when(mockGetTVSeriesDetail.execute(idTest))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTVSeriesBloc;
      },
      act: (bloc) => bloc.add(DetailTVSeries(idTest)),
      expect: () => [
        TVSeriesDetailLoading(),
        const TVSeriesDetailError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(idTest));
      },
    );
  });
}
