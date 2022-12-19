import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/season/detail';

  final int id;
  final int seasonNumber;
  TVSeriesSeasonDetailPage({required this.id, required this.seasonNumber});

  @override
  _TVSeriesSeasonDetailPageState createState() =>
      _TVSeriesSeasonDetailPageState();
}

class _TVSeriesSeasonDetailPageState extends State<TVSeriesSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TVSeriesSeasonDetailBloc>().add(
            TVSeriesSeasonDetail(widget.id, widget.seasonNumber),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVSeriesSeasonDetailBloc, TVSeriesSeasonState>(
        builder: (context, state) {
          if (state is TopRatedTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeriesSeasonDetailHasData) {
            final season = state.resultTVSeriesSeasonDetail;
            return SafeArea(
              child: DetailContent(
                season,
              ),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeasonDetail season;

  DetailContent(this.season);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              season.name,
                              style: kHeading5,
                            ),
                            Text(
                              _airDate(season.airDate),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            // List of episodes with netlfix list style with air date and runtime with expandable list
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: season.episodes.length,
                              itemBuilder: (context, index) {
                                final episode = season.episodes[index];
                                return ExpansionTile(
                                  title: Text(
                                    episode.name,
                                  ),
                                  subtitle: Text(
                                    _airDate(episode.airDate),
                                  ),
                                  leading: Text(
                                    '${episode.episodeNumber}',
                                  ),
                                  trailing: Text(
                                    '${episode.runtime} min',
                                  ),
                                  children: [
                                    Text(
                                      episode.overview,
                                    ),
                                    SizedBox(height: 8),
                                    // Votes
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          '${episode.voteAverage}',
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _airDate(String? airDate) {
    if (airDate == null) {
      return '';
    }

    if (airDate.compareTo(DateTime.now().toString()) > 0) {
      return '$airDate (N/A)';
    }

    return 'Air Date: $airDate';
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDurationAndEpisode(int season, int episode) {
    return '$season seasons ($episode episodes)';
  }
}
