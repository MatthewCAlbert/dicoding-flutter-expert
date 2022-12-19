import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

//Now playing movie
class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovie;

  NowPlayingMovieBloc(this._getNowPlayingMovie)
      : super(NowPlayingMovieEmpty()) {
    on<NowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovie.execute();

      result.fold((failure) => emit(NowPlayingMovieError(failure.message)),
          (result) => emit(NowPlayingMovieHasData(result)));
    });
  }
}

//Popular movie
class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovie;

  PopularMovieBloc(this._getPopularMovie) : super(PopularMovieEmpty()) {
    on<PopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovie.execute();

      result.fold((failure) => emit(PopularMovieError(failure.message)),
          (result) => emit(PopularMovieHasData(result)));
    });
  }
}

//Top rated movie
class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovie;

  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieEmpty()) {
    on<TopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovie.execute();

      result.fold((failure) => emit(TopRatedMovieError(failure.message)),
          (result) => emit(TopRatedMovieHasData(result)));
    });
  }
}

//Detail movie
class DetailMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<DetailMovie>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold((failure) => emit(MovieDetailError(failure.message)),
          (result) => emit(MovieDetailHasData(result)));
    });
  }
}

//Watchlist movie
class WatchlistMovieBloc extends Bloc<MovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(WatchlistMovieEmpty()) {
    on<WatchlistMovieList>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieHasList(data));
      });
    });

    on<WatchlistStatus>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchListStatus.execute(event.id);

      emit(WatchlistMovieHasStatus(result));
    });

    on<AddWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      final result = await saveWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieHasMessage(message));
      });
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;

      final result = await removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieHasMessage(message));
      });
    });
  }
}

//Recommendationmendation movie
class RecommendationmendationMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendationmendations;

  RecommendationmendationMovieBloc(this._getMovieRecommendationmendations)
      : super(MovieRecommendationEmpty()) {
    on<RecommendationMovie>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationLoading());

      final result = await _getMovieRecommendationmendations.execute(id);

      result.fold((failure) {
        emit(MovieRecommendationError(failure.message));
      }, (data) {
        emit(MovieRecommendationHasData(data));
      });
    });
  }
}
