import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SearchTVSeries {
  final TvSeriesRepository repository;

  SearchTVSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
