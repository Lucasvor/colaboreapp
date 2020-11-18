part of 'homeong_bloc.dart';

class HomeongState {
  final bool isSucess;
  final bool isLoadHome;
  final bool isFailure;
  final String message;
  final Ong ong;

  HomeongState(
      {this.ong, this.isSucess, this.isLoadHome, this.isFailure, this.message});

  factory HomeongState.initial() {
    return HomeongState(isFailure: false, isSucess: false, isLoadHome: false);
  }

  factory HomeongState.loading() {
    return HomeongState(isSucess: false, isFailure: false, isLoadHome: true);
  }
  factory HomeongState.failure({String message}) {
    return HomeongState(
        message: message, isSucess: false, isFailure: false, isLoadHome: true);
  }

  factory HomeongState.sucess({Ong ong}) {
    return HomeongState(
        isSucess: true, isFailure: false, isLoadHome: true, ong: ong);
  }
}

class HomeongInitial extends HomeongState {}
