part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class LoadHomePageEvent extends HomePageEvent {
  final Completer? completer;

  const LoadHomePageEvent({this.completer});
  @override
  List<Object> get props => [];
}