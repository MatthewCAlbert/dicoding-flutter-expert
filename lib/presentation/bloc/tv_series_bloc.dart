import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_event.dart';
part 'tv_series_state.dart';

//TV season detail
class TVSeriesSeasonDetailBloc
    extends Bloc<TVSeriesSeasonEvent, TVSeriesSeasonState> {
  final GetTVSeriesSeasonDetail _getTVSeriesSeasonDetail;

  TVSeriesSeasonDetailBloc(this._getTVSeriesSeasonDetail)
      : super(TVSeriesSeasonDetailEmpty()) {
    on<TVSeriesSeasonDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      emit(TVSeriesSeasonDetailLoading());
      final result = await _getTVSeriesSeasonDetail.execute(id, seasonNumber);

      result.fold((failure) => emit(TVSeriesSeasonDetailError(failure.message)),
          (result) => emit(TVSeriesSeasonDetailHasData(result)));
    });
  }
}

//Now playing TV series
class OnTheAirTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetNowPlayingTVSeries _getOnTheAirTVSeries;

  OnTheAirTVSeriesBloc(this._getOnTheAirTVSeries)
      : super(OnTheAirTVSeriesEmpty()) {
    on<OnTheAirTVSeries>((event, emit) async {
      emit(OnTheAirTVSeriesLoading());
      final result = await _getOnTheAirTVSeries.execute();

      result.fold((failure) => emit(OnTheAirTVSeriesError(failure.message)),
          (result) => emit(OnTheAirTVSeriesHasData(result)));
    });
  }
}

//Popular TV series
class PopularTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesBloc(this._getPopularTVSeries)
      : super(PopularTVSeriesEmpty()) {
    on<PopularTVSeries>((event, emit) async {
      emit(PopularTVSeriesLoading());
      final result = await _getPopularTVSeries.execute();

      result.fold((failure) => emit(PopularTVSeriesError(failure.message)),
          (result) => emit(PopularTVSeriesHasData(result)));
    });
  }
}

//Top rated TV series
class TopRatedTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TopRatedTVSeriesBloc(this._getTopRatedTVSeries)
      : super(TopRatedTVSeriesEmpty()) {
    on<TopRatedTVSeries>((event, emit) async {
      emit(TopRatedTVSeriesLoading());
      final result = await _getTopRatedTVSeries.execute();

      result.fold((failure) => emit(TopRatedTVSeriesError(failure.message)),
          (result) => emit(TopRatedTVSeriesHasData(result)));
    });
  }
}

//Detail TV series
class TVSeriesDetailBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetTVSeriesDetail _getTVSeriesDetail;

  TVSeriesDetailBloc(this._getTVSeriesDetail) : super(TVSeriesDetailEmpty()) {
    on<DetailTVSeries>((event, emit) async {
      final id = event.id;

      emit(TVSeriesDetailLoading());
      final result = await _getTVSeriesDetail.execute(id);

      result.fold((failure) => emit(TVSeriesDetailError(failure.message)),
          (result) => emit(TVSeriesDetailHasData(result)));
    });
  }
}

//Watchlist TV series
class WatchlistTVSeriesBloc
    extends Bloc<TVSeriesEvent, WatchlistTVSeriesState> {
  final GetTVSeriesWatchlist getWatchlistTVSeries;
  final GetTVSeriesWatchlistStatus getWatchlistTVSeriesStatus;
  final RemoveTVSeriesWatchlist removeTVSeriesWatchlist;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;

  WatchlistTVSeriesBloc({
    required this.getWatchlistTVSeries,
    required this.getWatchlistTVSeriesStatus,
    required this.removeTVSeriesWatchlist,
    required this.saveTVSeriesWatchlist,
  }) : super(WatchlistTVSeriesEmpty()) {
    on<WatchlistTVSeriesList>((event, emit) async {
      emit(WatchlistTVSeriesLoading());

      final result = await getWatchlistTVSeries.execute();

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (data) {
        emit(WatchlistTVSeriesHasList(data));
      });
    });

    on<WatchlistStatusTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());
      final result = await getWatchlistTVSeriesStatus.execute(event.id);

      emit(WatchlistTVSeriesHasStatus(result));
    });

    on<AddWatchlistTVSeries>((event, emit) async {
      final tv = event.tvDetail;
      final result = await saveTVSeriesWatchlist.execute(tv);

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (message) {
        emit(WatchlistTVSeriesHasMessage(message));
      });
    });

    on<RemoveWatchlistTVSeries>((event, emit) async {
      final tv = event.tvDetail;

      final result = await removeTVSeriesWatchlist.execute(tv);

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (message) {
        emit(WatchlistTVSeriesHasMessage(message));
      });
    });
  }
}

//Recommendation TV series
class RecommendationTVSeriesBloc extends Bloc<TVSeriesEvent, TVSeriesState> {
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;

  RecommendationTVSeriesBloc(this._getTVSeriesRecommendations)
      : super(TVSeriesRecommendationEmpty()) {
    on<RecommendationTVSeries>((event, emit) async {
      final id = event.id;

      emit(TVSeriesRecommendationLoading());

      final result = await _getTVSeriesRecommendations.execute(id);

      result.fold((failure) {
        emit(TVSeriesRecommendationError(failure.message));
      }, (data) {
        emit(TVSeriesRecommendationHasData(data));
      });
    });
  }
}
