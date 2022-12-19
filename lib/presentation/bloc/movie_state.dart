part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

//Now playing movie state
class NowPlayingMovieEmpty extends MovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends MovieState {}

class NowPlayingMovieError extends MovieState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends MovieState {
  final List<Movie> resultNowPlayingMovie;

  const NowPlayingMovieHasData(this.resultNowPlayingMovie);

  @override
  List<Object> get props => [resultNowPlayingMovie];
}

//Popular movie state
class PopularMovieEmpty extends MovieState {}

class PopularMovieLoading extends MovieState {}

class PopularMovieError extends MovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends MovieState {
  final List<Movie> resultPopularMovie;

  const PopularMovieHasData(this.resultPopularMovie);

  @override
  List<Object> get props => [resultPopularMovie];
}

//Top rated movie state
class TopRatedMovieEmpty extends MovieState {}

class TopRatedMovieLoading extends MovieState {}

class TopRatedMovieError extends MovieState {
  final String message;

  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieHasData extends MovieState {
  final List<Movie> resultTopRatedMovie;

  const TopRatedMovieHasData(this.resultTopRatedMovie);

  @override
  List<Object> get props => [resultTopRatedMovie];
}

//Detail movie state
class MovieDetailEmpty extends MovieState {}

class MovieDetailLoading extends MovieState {}

class MovieDetailError extends MovieState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieState {
  final MovieDetail movieDetail;

  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

//Watchlist movie state
class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasStatus extends WatchlistMovieState {
  final bool result;

  const WatchlistMovieHasStatus(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistMovieHasMessage extends WatchlistMovieState {
  final String message;

  const WatchlistMovieHasMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasList extends WatchlistMovieState {
  final List<Movie> movie;

  const WatchlistMovieHasList(this.movie);

  @override
  List<Object?> get props => [movie];
}

//Recommendationmendation movie state
class MovieRecommendationEmpty extends MovieState {}

class MovieRecommendationLoading extends MovieState {}

class MovieRecommendationError extends MovieState {
  final String message;

  const MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MovieState {
  final List<Movie> movie;

  const MovieRecommendationHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
