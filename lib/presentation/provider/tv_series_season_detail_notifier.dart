import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TVSeriesSeasonNotifier extends ChangeNotifier {
  final GetTVSeriesSeasonDetail getTVSeriesSeasonDetail;

  TVSeriesSeasonNotifier({
    required this.getTVSeriesSeasonDetail,
  });

  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;

  RequestState _seasonDetailState = RequestState.Empty;
  RequestState get seasonDetailState => _seasonDetailState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeriesSeasonDetail(int id, int seasonNumber) async {
    _seasonDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult =
        await getTVSeriesSeasonDetail.execute(id, seasonNumber);
    detailResult.fold(
      (failure) {
        _seasonDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonDetail) {
        _seasonDetailState = RequestState.Loaded;
        _seasonDetail = seasonDetail;
        notifyListeners();
      },
    );
  }
}
