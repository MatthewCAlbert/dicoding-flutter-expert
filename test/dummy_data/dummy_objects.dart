import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/season_detail.dart';

// Movie
final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV Series
final testTvSeries = TvSeries(
  backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
  firstAirDate: "2021-09-03",
  genreIds: [10764],
  id: 130392,
  name: "The D'Amelio Show",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The D'Amelio Show",
  overview:
      "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the DAmelios are faced with new challenges and opportunities they could not have imagined.",
  popularity: 29.21,
  posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
  voteAverage: 9,
  voteCount: 3145,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    nextEpisodeToAir: null,
    episodeRunTime: [60],
    firstAirDate: "2011-04-17",
    genres: [Genre(id: 1, name: 'Action')],
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2019-05-19",
    name: "Game of Thrones",
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview: "overview",
    popularity: 550.839,
    posterPath: "/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg",
    seasons: [
      Season(
          airDate: "2011-04-17",
          episodeCount: 10,
          id: 3624,
          name: "Season 1",
          overview: "aaaa",
          posterPath: "/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg",
          seasonNumber: 1)
    ],
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.43,
    voteCount: 19870);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'Game of Thrones',
  posterPath: '/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg',
  overview: 'overview',
);

final testTvSeriesTable = TVSeriesTable(
  id: 1,
  name: 'Game of Thrones',
  posterPath: '/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg',
  'name': 'Game of Thrones',
};

// Season
final testSeason = Season(
    airDate: "2011-04-17",
    episodeCount: 10,
    id: 3624,
    name: "Season 1",
    overview: "aaaa",
    posterPath: "/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg",
    seasonNumber: 1);

final testSeasonList = [testSeason];

final testSeasonDetail = SeasonDetail(
    id: "5256c89f19c2956ff6046d47",
    airDate: "2011-04-17",
    episodes: [
      Episode(
        airDate: "2011-04-17",
        episodeNumber: 1,
        id: 63056,
        name: "Winter Is Coming",
        overview:
            "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
        productionCode: "101",
        runtime: 62,
        seasonNumber: 1,
        showId: 1399,
        stillPath: "/9hGF3WUkBf7cSjMg0cdMDHJkByd.jpg",
        voteAverage: 7.8,
        voteCount: 273,
      )
    ],
    name: "Season 1",
    overview:
        "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.",
    posterPath: "/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg",
    seasonNumber: 1);

final testSeasonMap = {};

// Episode
final testEpisode = Episode(
  airDate: "2011-04-17",
  episodeNumber: 1,
  id: 63056,
  name: "Winter Is Coming",
  overview:
      "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
  productionCode: "101",
  runtime: 62,
  seasonNumber: 1,
  showId: 1399,
  stillPath: "/9hGF3WUkBf7cSjMg0cdMDHJkByd.jpg",
  voteAverage: 7.8,
  voteCount: 273,
);
