import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TVSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
