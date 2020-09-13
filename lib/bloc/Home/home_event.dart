part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LogOutButtonPressedEvent extends HomeEvent {}

class LoadingOngs extends HomeEvent {
  @override
  List<Object> get props => [];
}
