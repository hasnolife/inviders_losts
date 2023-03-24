part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitialState extends HomePageState {
  @override
  List<Object> get props => [];
}
class HomePageLoadingState extends HomePageState {
  @override
  List<Object> get props => [];
}
class HomePageLoadedState extends HomePageState {
  final TodayDataModel todayDataModel;

  @override
  List<Object> get props => [];

  const HomePageLoadedState({
    required this.todayDataModel,
  });
}
class HomePageLoadingErrorState extends HomePageState {
  final Object? error;

  const HomePageLoadingErrorState({this.error});
  @override
  List<Object> get props => [];
}

