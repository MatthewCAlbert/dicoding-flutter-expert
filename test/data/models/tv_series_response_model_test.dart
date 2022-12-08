import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVSeriesModel = TvSeriesModel(
    backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
    firstAirDate: "2011-02-28",
    genreIds: [18, 80],
    id: 31586,
    name: "La Reina del Sur",
    originCountry: ["US"],
    originalLanguage: "es",
    originalName: "La Reina del Sur",
    overview:
        "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
    popularity: 1779.015,
    posterPath: "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
    voteAverage: 7.8,
    voteCount: 1455,
  );
  final tTVSeriesResponseModel =
      TVSeriesResponse(seriesList: <TvSeriesModel>[tTVSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
            "first_air_date": "2011-02-28",
            "genre_ids": [18, 80],
            "id": 31586,
            "name": "La Reina del Sur",
            "origin_country": ["US"],
            "original_language": "es",
            "original_name": "La Reina del Sur",
            "overview":
                "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
            "popularity": 1779.015,
            "poster_path": "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
            "vote_average": 7.8,
            "vote_count": 1455
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
