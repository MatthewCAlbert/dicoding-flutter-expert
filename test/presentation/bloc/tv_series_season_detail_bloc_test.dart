import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesSeasonDetailBloc tVSeriesSeasonDetailBloc;
  late MockGetTVSeriesSeasonDetail mockGetTVSeriesSeasonDetail;

  setUp(() {
    mockGetTVSeriesSeasonDetail = MockGetTVSeriesSeasonDetail();
    tVSeriesSeasonDetailBloc =
        TVSeriesSeasonDetailBloc(mockGetTVSeriesSeasonDetail);
  });

  test('TVSeriesSeasonDetailBloc initial state should be empty ', () {
    expect(tVSeriesSeasonDetailBloc.state, TVSeriesSeasonDetailEmpty());
  });

  const idTest = 1;
  const seasonNumberTest = 1;

  group('TV series season detail test', () {
    blocTest<TVSeriesSeasonDetailBloc, TVSeriesSeasonState>(
        'should emits [Loading, HasData] when data is successfully fetched.',
        build: () {
          when(mockGetTVSeriesSeasonDetail.execute(idTest, seasonNumberTest))
              .thenAnswer((_) async => Right(testSeasonDetail));
          return tVSeriesSeasonDetailBloc;
        },
        act: (bloc) => bloc.add(TVSeriesSeasonDetail(idTest, seasonNumberTest)),
        expect: () => <TVSeriesSeasonState>[
              TVSeriesSeasonDetailLoading(),
              TVSeriesSeasonDetailHasData(testSeasonDetail),
            ],
        verify: (bloc) {
          verify(mockGetTVSeriesSeasonDetail.execute(idTest, seasonNumberTest));
          return TVSeriesSeasonDetail(idTest, seasonNumberTest).props;
        });

    blocTest<TVSeriesSeasonDetailBloc, TVSeriesSeasonState>(
      'should emits [Loading, Error] when now playing TV series data is failed to fetch',
      build: () {
        when(mockGetTVSeriesSeasonDetail.execute(idTest, seasonNumberTest))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tVSeriesSeasonDetailBloc;
      },
      act: (bloc) => bloc.add(TVSeriesSeasonDetail(idTest, seasonNumberTest)),
      expect: () => <TVSeriesSeasonState>[
        TVSeriesSeasonDetailLoading(),
        const TVSeriesSeasonDetailError('Server Failure'),
      ],
      verify: (bloc) => TVSeriesSeasonDetailLoading(),
    );
  });
}
