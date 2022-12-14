import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

abstract class TVSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTVSeries();
  Future<List<TvSeriesModel>> getOnTheAirTVSeries();
  Future<List<TvSeriesModel>> getPopularTVSeries();
  Future<List<TvSeriesModel>> getTopRatedTVSeries();
  Future<TvSeriesDetailModel> getTVSeriesDetail(int id);
  Future<SeasonDetailModel> getSeasonDetail(int tvId, int seasonNumber);
  Future<List<TvSeriesModel>> getTVSeriesRecommendations(int id);
  Future<List<TvSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient? client;

  TVSeriesRemoteDataSourceImpl({required this.client});

  Future<IOClient> get globalContext async {
    if (this.client != null) {
      return this.client!;
    }
    final sslCert = await rootBundle.load('certificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

  @override
  Future<List<TvSeriesModel>> getAiringTodayTVSeries() async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getOnTheAirTVSeries() async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTVSeries() async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTVSeries() async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTVSeriesDetail(int id) async {
    final response = await (await globalContext).get(Uri.parse(
        '$BASE_URL/tv/$id?$API_KEY&append_to_response=videos,credits'));

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonDetail(int id, int seasonIndex) async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/$id/season/$seasonIndex?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTVSeries(String query) async {
    final response = await (await globalContext)
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}
