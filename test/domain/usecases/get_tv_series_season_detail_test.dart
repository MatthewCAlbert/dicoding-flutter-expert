import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesSeasonDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTVSeriesSeasonDetail(mockTvSeriesRepository);
  });

  final tId = 1;
  final sId = 1;

  test('should get tv series season detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getSeasonDetail(tId, sId))
        .thenAnswer((_) async => Right(testSeasonDetail));
    // act
    final result = await usecase.execute(tId, sId);
    // assert
    expect(result, Right(testSeasonDetail));
  });
}
