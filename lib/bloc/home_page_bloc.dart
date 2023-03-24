import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inviders_losts/api_client/api_client.dart';
import 'package:inviders_losts/entity/entity.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState()) {
    on<LoadHomePageEvent>((event, emit) async{
      if (state is! HomePageLoadedState) {
        emit(HomePageLoadingState());
      }
      try {
        final todayData = await _apiClient.getData();
        emit(HomePageLoadedState(todayDataModel: todayData));
      } catch (e) {
        emit(HomePageLoadingErrorState(error: e));
      } finally {
        event.completer?.complete();
      }
    });
    add(const LoadHomePageEvent());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  final _apiClient = ApiClient();

  Future<dynamic> onRefresh() {
    final completer = Completer();
    add(LoadHomePageEvent(completer: completer));
    return completer.future;
  }
}
