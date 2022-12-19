import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  test('WatchlistMovieBloc initial state should be empty ', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  group('Get watchlist movie test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emits [Loading, HasList] when watchlist movie list data is successfully fetched',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieList()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasList([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return WatchlistMovieList().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emits [Loading, Error] when watchlist movie list data is failed to fetch',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieList()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        const WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('Get watchlist status movie test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should be return true when the movie watchlist is also true',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistStatus(testMovieDetail.id)),
      expect: () =>
          [WatchlistMovieLoading(), const WatchlistMovieHasStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return WatchlistStatus(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should be return false when the movie watchlist is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(WatchlistStatus(testMovieDetail.id)),
        expect: () => <WatchlistMovieState>[
              WatchlistMovieLoading(),
              const WatchlistMovieHasStatus(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return WatchlistStatus(testMovieDetail.id).props;
        });
  });

  group('Add watchlist movie test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when add movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistMovieHasMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return AddWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when failed to add movie to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return AddWatchlistMovie(testMovieDetail).props;
      },
    );
  });

  group('Remove watchlist movie test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when remove movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistMovieHasMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return RemoveWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when failed to remove movie from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return RemoveWatchlistMovie(testMovieDetail).props;
      },
    );
  });
}
