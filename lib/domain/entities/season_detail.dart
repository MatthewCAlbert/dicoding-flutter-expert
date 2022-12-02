import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  SeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvSeriesSeasonId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int tvSeriesSeasonId;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        tvSeriesSeasonId,
        posterPath,
        seasonNumber,
      ];
}
