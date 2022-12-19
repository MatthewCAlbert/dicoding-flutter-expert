part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

//Now playing movie
class NowPlayingMovie extends MovieEvent {
  @override
  List<Object> get props => [];
}

//Popular movie
class PopularMovie extends MovieEvent {
  @override
  List<Object> get props => [];
}

//Top rated movie
class TopRatedMovie extends MovieEvent {
  @override
  List<Object> get props => [];
}

//Detail movie
class DetailMovie extends MovieEvent {
  final int id;

  const DetailMovie(this.id);

  @override
  List<Object> get props => [id];
}

//Watchlist movie list
class WatchlistMovieList extends MovieEvent {
  @override
  List<Object> get props => [];
}

//Watchlist movie status
class WatchlistStatus extends MovieEvent {
  final int id;

  const WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

//Remove watchlist movie
class RemoveWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

//Add watchlist movie
class AddWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

//Recommendation movie
class RecommendationMovie extends MovieEvent {
  final int id;

  const RecommendationMovie(this.id);
  @override
  List<Object> get props => [id];
}
