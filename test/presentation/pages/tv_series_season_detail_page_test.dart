import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helper.dart';

void main() {
  late FakeTVSeriesSeasonDetailBloc fakeTVSeriesSeasonDetailBloc;

  setUp(() {
    fakeTVSeriesSeasonDetailBloc = FakeTVSeriesSeasonDetailBloc();
    registerFallbackValue(FakeTopRatedTVSeriesEvent());
    registerFallbackValue(FakeTopRatedTVSeriesState());
  });

  tearDown(() {
    fakeTVSeriesSeasonDetailBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesSeasonDetailBloc>(
      create: (_) => fakeTVSeriesSeasonDetailBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() =>
        fakeTVSeriesSeasonDetailBloc
            .state).thenReturn(TVSeriesSeasonDetailHasData(SeasonDetail(
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
        seasonNumber: 1)));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesSeasonDetailPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
  });
}
