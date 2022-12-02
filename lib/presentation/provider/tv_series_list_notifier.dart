import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingTVSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTVSeries => _nowPlayingTVSeries;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTVSeries = <TvSeries>[];
  List<TvSeries> get popularTVSeries => _popularTVSeries;

  RequestState _popularTVSeriesState = RequestState.Empty;
  RequestState get popularTVSeriesState => _popularTVSeriesState;

  var _topRatedTVSeries = <TvSeries>[];
  List<TvSeries> get topRatedTVSeries => _topRatedTVSeries;

  RequestState _topRatedTVSeriesState = RequestState.Empty;
  RequestState get topRatedTVSeriesState => _topRatedTVSeriesState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getNowPlayingTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  final GetNowPlayingTVSeries getNowPlayingTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  Future<void> fetchNowPlayingTVSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVSeries() async {
    _popularTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTVSeriesState = RequestState.Loaded;
        _popularTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTVSeries() async {
    _topRatedTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _topRatedTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTVSeriesState = RequestState.Loaded;
        _topRatedTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
