part of 'tv_series_bloc.dart';

abstract class TVSeriesEvent extends Equatable {
  const TVSeriesEvent();
}

abstract class TVSeriesSeasonEvent extends Equatable {
  const TVSeriesSeasonEvent();
}

//Now playing TV series
class OnTheAirTVSeries extends TVSeriesEvent {
  @override
  List<Object> get props => [];
}

//Tv series season detail
class TVSeriesSeasonDetail extends TVSeriesSeasonEvent {
  final int id;
  final int seasonNumber;

  const TVSeriesSeasonDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id];
}

//Popular TV series
class PopularTVSeries extends TVSeriesEvent {
  @override
  List<Object> get props => [];
}

//Top rated TV series
class TopRatedTVSeries extends TVSeriesEvent {
  @override
  List<Object> get props => [];
}

//Detail TV series
class DetailTVSeries extends TVSeriesEvent {
  final int id;

  const DetailTVSeries(this.id);

  @override
  List<Object> get props => [id];
}

//Watchlist TV series list
class WatchlistTVSeriesList extends TVSeriesEvent {
  @override
  List<Object> get props => [];
}

//Watchlist TV series status
class WatchlistStatusTVSeries extends TVSeriesEvent {
  final int id;

  const WatchlistStatusTVSeries(this.id);

  @override
  List<Object> get props => [id];
}

//Remove TV series movie
class RemoveWatchlistTVSeries extends TVSeriesEvent {
  final TvSeriesDetail tvDetail;

  const RemoveWatchlistTVSeries(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Add watchlist TV series
class AddWatchlistTVSeries extends TVSeriesEvent {
  final TvSeriesDetail tvDetail;

  const AddWatchlistTVSeries(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Recommendation TV series
class RecommendationTVSeries extends TVSeriesEvent {
  final int id;

  const RecommendationTVSeries(this.id);
  @override
  List<Object> get props => [id];
}
