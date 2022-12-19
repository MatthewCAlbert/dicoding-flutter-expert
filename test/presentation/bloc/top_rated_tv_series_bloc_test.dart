import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  test("TopRatedTVSeriesBloc initial state should be empty", () {
    expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesEmpty());
  });

  final tvList = <TvSeries>[];
  group(
    'Top rated TV series test',
    () {
      blocTest<TopRatedTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, HasData] when top rated TVSeries data is fetched successfully',
        build: () {
          when(mockGetTopRatedTVSeries.execute())
              .thenAnswer((_) async => Right(tvList));
          return topRatedTVSeriesBloc;
        },
        act: (bloc) => bloc.add(TopRatedTVSeries()),
        expect: () =>
            [TopRatedTVSeriesLoading(), TopRatedTVSeriesHasData(tvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTVSeries.execute());
        },
      );

      blocTest<TopRatedTVSeriesBloc, TVSeriesState>(
        'Should emit [Loading, Error] when get top rated TVSeries data is failed to fetched',
        build: () {
          when(mockGetTopRatedTVSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedTVSeriesBloc;
        },
        act: (bloc) => bloc.add(TopRatedTVSeries()),
        expect: () => [
          TopRatedTVSeriesLoading(),
          const TopRatedTVSeriesError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTopRatedTVSeries.execute());
        },
      );
    },
  );
}
