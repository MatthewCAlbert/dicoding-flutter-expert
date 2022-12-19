part of 'tv_series_bloc.dart';

abstract class TVSeriesState extends Equatable {
  const TVSeriesState();

  @override
  List<Object> get props => [];
}

abstract class TVSeriesSeasonState extends Equatable {
  const TVSeriesSeasonState();

  @override
  List<Object> get props => [];
}

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object?> get props => [];
}

//Now playing TV series state
class OnTheAirTVSeriesEmpty extends TVSeriesState {}

class OnTheAirTVSeriesLoading extends TVSeriesState {}

class OnTheAirTVSeriesError extends TVSeriesState {
  final String message;

  const OnTheAirTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTVSeriesHasData extends TVSeriesState {
  final List<TvSeries> resultOnTheAirTVSeries;

  const OnTheAirTVSeriesHasData(this.resultOnTheAirTVSeries);

  @override
  List<Object> get props => [resultOnTheAirTVSeries];
}

//TV Series Season state
class TVSeriesSeasonDetailEmpty extends TVSeriesSeasonState {}

class TVSeriesSeasonDetailLoading extends TVSeriesSeasonState {}

class TVSeriesSeasonDetailError extends TVSeriesSeasonState {
  final String message;

  const TVSeriesSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesSeasonDetailHasData extends TVSeriesSeasonState {
  final SeasonDetail resultTVSeriesSeasonDetail;

  const TVSeriesSeasonDetailHasData(this.resultTVSeriesSeasonDetail);

  @override
  List<Object> get props => [resultTVSeriesSeasonDetail];
}

//Popular TV series state
class PopularTVSeriesEmpty extends TVSeriesState {}

class PopularTVSeriesLoading extends TVSeriesState {}

class PopularTVSeriesError extends TVSeriesState {
  final String message;

  const PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVSeriesHasData extends TVSeriesState {
  final List<TvSeries> resultPopularTVSeries;

  const PopularTVSeriesHasData(this.resultPopularTVSeries);

  @override
  List<Object> get props => [resultPopularTVSeries];
}

//Top rated TV series state
class TopRatedTVSeriesEmpty extends TVSeriesState {}

class TopRatedTVSeriesLoading extends TVSeriesState {}

class TopRatedTVSeriesError extends TVSeriesState {
  final String message;

  const TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVSeriesHasData extends TVSeriesState {
  final List<TvSeries> resultTopRatedTVSeries;

  const TopRatedTVSeriesHasData(this.resultTopRatedTVSeries);

  @override
  List<Object> get props => [resultTopRatedTVSeries];
}

//Detail TV series state
class TVSeriesDetailEmpty extends TVSeriesState {}

class TVSeriesDetailLoading extends TVSeriesState {}

class TVSeriesDetailError extends TVSeriesState {
  final String message;

  const TVSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesDetailHasData extends TVSeriesState {
  final TvSeriesDetail tvDetail;

  const TVSeriesDetailHasData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Watchlist TV series state
class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  final String message;

  const WatchlistTVSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTVSeriesHasStatus extends WatchlistTVSeriesState {
  final bool result;

  const WatchlistTVSeriesHasStatus(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTVSeriesHasMessage extends WatchlistTVSeriesState {
  final String message;

  const WatchlistTVSeriesHasMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVSeriesHasList extends WatchlistTVSeriesState {
  final List<TvSeries> tv;

  const WatchlistTVSeriesHasList(this.tv);

  @override
  List<Object?> get props => [tv];
}

//Recommendationmendation TV series state
class TVSeriesRecommendationEmpty extends TVSeriesState {}

class TVSeriesRecommendationLoading extends TVSeriesState {}

class TVSeriesRecommendationError extends TVSeriesState {
  final String message;

  const TVSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesRecommendationHasData extends TVSeriesState {
  final List<TvSeries> tv;

  const TVSeriesRecommendationHasData(this.tv);

  @override
  List<Object> get props => [tv];
}
