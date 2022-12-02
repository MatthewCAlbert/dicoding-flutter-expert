import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class SeasonDetailModel extends Equatable {
  SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonDetailModelId;
  final dynamic posterPath;
  final int seasonNumber;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonDetailModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonDetailModelId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  SeasonDetailModel toEntity() {
    return SeasonDetailModel(
      id: this.id,
      airDate: this.airDate,
      episodes: this.episodes,
      name: this.name,
      overview: this.overview,
      seasonDetailModelId: this.seasonDetailModelId,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonDetailModelId,
        posterPath,
        seasonNumber,
      ];
}
