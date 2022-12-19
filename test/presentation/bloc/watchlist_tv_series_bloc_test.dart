import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;
  late MockGetTVSeriesWatchlist mockGetTVSeriesWatchlist;
  late MockGetTVSeriesWatchlistStatus mockGetTVSeriesWatchlistStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;

  setUp(() {
    mockGetTVSeriesWatchlist = MockGetTVSeriesWatchlist();
    mockGetTVSeriesWatchlistStatus = MockGetTVSeriesWatchlistStatus();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();
    watchlistTVSeriesBloc = WatchlistTVSeriesBloc(
        getWatchlistTVSeries: mockGetTVSeriesWatchlist,
        getWatchlistTVSeriesStatus: mockGetTVSeriesWatchlistStatus,
        removeTVSeriesWatchlist: mockRemoveTVSeriesWatchlist,
        saveTVSeriesWatchlist: mockSaveTVSeriesWatchlist);
  });
  test('WatchlistTVSeriesBloc initial state should be empty ', () {
    expect(watchlistTVSeriesBloc.state, WatchlistTVSeriesEmpty());
  });

  group('Get watchlist TV series test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should emits [Loading, HasList] when watchlist TV series list data is successfully fetched',
      build: () {
        when(mockGetTVSeriesWatchlist.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeriesList()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesHasList([testWatchlistTvSeries]),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesWatchlist.execute());
        return WatchlistTVSeriesList().props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should emits [Loading, Error] when watchlist TV series list data is failed to fetch',
      build: () {
        when(mockGetTVSeriesWatchlist.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeriesList()),
      expect: () => <WatchlistTVSeriesState>[
        WatchlistTVSeriesLoading(),
        const WatchlistTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('Get watchlist status TV series test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should be return true when the TV series watchlist is also true',
      build: () {
        when(mockGetTVSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistStatusTVSeries(testTvSeriesDetail.id)),
      expect: () =>
          [WatchlistTVSeriesLoading(), const WatchlistTVSeriesHasStatus(true)],
      verify: (bloc) {
        verify(mockGetTVSeriesWatchlistStatus.execute(testTvSeriesDetail.id));
        return WatchlistStatusTVSeries(testTvSeriesDetail.id).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
        'should be return false when the TV series watchlist is also false',
        build: () {
          when(mockGetTVSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTVSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchlistStatusTVSeries(testTvSeriesDetail.id)),
        expect: () => <WatchlistTVSeriesState>[
              WatchlistTVSeriesLoading(),
              const WatchlistTVSeriesHasStatus(false),
            ],
        verify: (bloc) {
          verify(mockGetTVSeriesWatchlistStatus.execute(testTvSeriesDetail.id));
          return WatchlistStatusTVSeries(testTvSeriesDetail.id).props;
        });
  });

  group('Add watchlist TV series test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should update watchlist status when add TVSeries to watchlist is successfully',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTVSeriesHasMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return AddWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should throw failure message status when failed to add TV series to watchlist',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTVSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return AddWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );
  });

  group('Remove watchlist TV series test', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should update watchlist status when remove TV series from watchlist is successfully',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTVSeriesHasMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return RemoveWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'should throw failure message status when failed to remove TV series from watchlist',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async =>
                Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTVSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTVSeries(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTVSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return RemoveWatchlistTVSeries(testTvSeriesDetail).props;
      },
    );
  });
}
