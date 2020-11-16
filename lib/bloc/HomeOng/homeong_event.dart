part of 'homeong_bloc.dart';

abstract class HomeongEvent extends Equatable {
  const HomeongEvent();

  @override
  List<Object> get props => [];
}

class LogOutButtonPressedEvent extends HomeongEvent {}

class LoadHomeOng extends HomeongEvent {
  @override
  List<Object> get props => [];
}
