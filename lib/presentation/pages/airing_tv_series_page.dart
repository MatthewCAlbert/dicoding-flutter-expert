import 'package:ditonton/presentation/bloc/tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-tv-series';

  @override
  AiringTVSeriesPageState createState() => AiringTVSeriesPageState();
}

class AiringTVSeriesPageState extends State<AiringTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<OnTheAirTVSeriesBloc>(context, listen: false).add(
        OnTheAirTVSeries(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTVSeriesBloc, TVSeriesState>(
          builder: (context, state) {
            if (state is OnTheAirTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTVSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.resultOnTheAirTVSeries[index];
                  return TVSeriesCard(tv);
                },
                itemCount: state.resultOnTheAirTVSeries.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
