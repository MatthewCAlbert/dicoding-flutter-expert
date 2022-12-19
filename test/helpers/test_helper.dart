import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
  IOClient,
  SearchMovies,
  GetMovieDetail,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetMovieRecommendations,
  GetTopRatedMovies,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
  SearchTVSeries,
  GetTVSeriesSeasonDetail,
  GetTVSeriesDetail,
  GetNowPlayingTVSeries,
  GetPopularTVSeries,
  GetTVSeriesRecommendations,
  GetTopRatedTVSeries,
  GetTVSeriesWatchlist,
  GetTVSeriesWatchlistStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// Movie
class FakeMovieSearchEvent extends Fake implements SearchEvent {}

class FakeMovieSearchState extends Fake implements SearchState {}

class FakeMovieSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements MovieSearchBloc {}

class FakeNowPlayingMovieEvent extends Fake implements MovieEvent {}

class FakeNowPlayingMovieState extends Fake implements MovieState {}

class FakeNowPlayingMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMovieBloc {}

class FakePopularMovieEvent extends Fake implements MovieEvent {}

class FakePopularMovieState extends Fake implements MovieState {}

class FakePopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

class FakeTopRatedMovieEvent extends Fake implements MovieEvent {}

class FakeTopRatedMovieState extends Fake implements MovieState {}

class FakeTopRatedMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

class FakeDetailMovieEvent extends Fake implements MovieEvent {}

class FakeDetailMovieState extends Fake implements MovieState {}

class FakeDetailMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

class FakeRecommendationMovieEvent extends Fake implements MovieEvent {}

class FakeRecommendationMovieState extends Fake implements MovieState {}

class FakeRecommendationMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements RecommendationmendationMovieBloc {}

class FakeWatchlistMovieEvent extends Fake implements MovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc extends MockBloc<MovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

// TV Series
class FakeTVSeriesSearchEvent extends Fake implements SearchEvent {}

class FakeTVSeriesSearchState extends Fake implements SearchState {}

class FakeTVSeriesSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements TVSeriesSearchBloc {}

class FakeOnTheAirTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakeOnTheAirTVSeriesState extends Fake implements TVSeriesState {}

class FakeOnTheAirTVSeriesBloc extends MockBloc<TVSeriesEvent, TVSeriesState>
    implements OnTheAirTVSeriesBloc {}

class FakePopularTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakePopularTVSeriesState extends Fake implements TVSeriesState {}

class FakePopularTVSeriesBloc extends MockBloc<TVSeriesEvent, TVSeriesState>
    implements PopularTVSeriesBloc {}

class FakeTopRatedTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakeTopRatedTVSeriesState extends Fake implements TVSeriesState {}

class FakeTopRatedTVSeriesBloc extends MockBloc<TVSeriesEvent, TVSeriesState>
    implements TopRatedTVSeriesBloc {}

class FakeDetailTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakeDetailTVSeriesState extends Fake implements TVSeriesState {}

class FakeDetailTVSeriesBloc extends MockBloc<TVSeriesEvent, TVSeriesState>
    implements TVSeriesDetailBloc {}

class FakeRecommendationTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakeRecommendationTVSeriesState extends Fake implements TVSeriesState {}

class FakeRecommendationTVSeriesBloc
    extends MockBloc<TVSeriesEvent, TVSeriesState>
    implements RecommendationTVSeriesBloc {}

class FakeWatchlistTVSeriesEvent extends Fake implements TVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class FakeWatchlistTVSeriesBloc
    extends MockBloc<TVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}

class FakeTVSeriesSeasonEvent extends Fake implements TVSeriesEvent {}

class FakeTVSeriesSeasonState extends Fake implements TVSeriesSeasonState {}

class FakeTVSeriesSeasonDetailBloc
    extends MockBloc<TVSeriesSeasonEvent, TVSeriesSeasonState>
    implements TVSeriesSeasonDetailBloc {}
