import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/provider/airing_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeriess;
  late AiringTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTVSeriess = MockGetNowPlayingTVSeries();
    notifier =
        AiringTVSeriesNotifier(getAiringSeries: mockGetNowPlayingTVSeriess)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTVSeries = TvSeries(
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

  final tTVSeriesList = <TvSeries>[tTVSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTVSeriess.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    notifier.fetchAiringTVSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTVSeriess.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    await notifier.fetchAiringTVSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTVSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTVSeriess.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchAiringTVSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
