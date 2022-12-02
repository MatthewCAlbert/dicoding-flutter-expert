import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertWatchlist(TVSeriesTable tvSeries);
  Future<String> removeWatchlist(TVSeriesTable tvSeries);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertTVSeriesWatchlist(tvSeries);
      return 'Added to watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeTVSeriesWatchlist(tvSeries);
      return 'Removed from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTVSeries() async {
    final result = await databaseHelper.getTVSeriesWatchlist();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }
}
