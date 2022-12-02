import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesWatchlistStatus {
  final TvSeriesRepository repository;

  GetTVSeriesWatchlistStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
