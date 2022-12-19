import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late OnTheAirTVSeriesBloc nowPlayingTVSeriesBloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    nowPlayingTVSeriesBloc = OnTheAirTVSeriesBloc(mockGetNowPlayingTVSeries);
  });

  test('OnTheAirTVSeriesBloc initial state should be empty ', () {
    expect(nowPlayingTVSeriesBloc.state, OnTheAirTVSeriesEmpty());
  });

  group('Now playing TV series test', () {
    blocTest<OnTheAirTVSeriesBloc, TVSeriesState>(
        'should emits [Loading, HasData] when data is successfully fetched.',
        build: () {
          when(mockGetNowPlayingTVSeries.execute())
              .thenAnswer((_) async => Right(testTvSeriesList));
          return nowPlayingTVSeriesBloc;
        },
        act: (bloc) => bloc.add(OnTheAirTVSeries()),
        expect: () => <TVSeriesState>[
              OnTheAirTVSeriesLoading(),
              OnTheAirTVSeriesHasData(testTvSeriesList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTVSeries.execute());
          return OnTheAirTVSeries().props;
        });

    blocTest<OnTheAirTVSeriesBloc, TVSeriesState>(
      'should emits [Loading, Error] when now playing TV series data is failed to fetch',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(OnTheAirTVSeries()),
      expect: () => <TVSeriesState>[
        OnTheAirTVSeriesLoading(),
        const OnTheAirTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => OnTheAirTVSeriesLoading(),
    );
  });
}
