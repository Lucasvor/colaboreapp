part of 'home_bloc.dart';

// abstract class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }

// class HomeInitial extends HomeState {}

// class LogOutSucess extends HomeState {}

class HomeState {
  final bool isSucess;
  final bool isLoadingOngs;
  final bool isFailure;
  final String message;
  final List<Ong> ongs;
  final Usuario usuario;

  HomeState(
      {this.ongs,
      this.usuario,
      this.message,
      this.isSucess,
      this.isLoadingOngs,
      this.isFailure});

  factory HomeState.initial() {
    return HomeState(isFailure: false, isSucess: false, isLoadingOngs: false);
  }
  factory HomeState.loading() {
    return HomeState(isSucess: false, isFailure: false, isLoadingOngs: true);
  }
  factory HomeState.failure({String message}) {
    return HomeState(
        message: message,
        isLoadingOngs: false,
        isFailure: true,
        isSucess: false);
  }
  factory HomeState.sucess({List<Ong> ongs, Usuario usuario}) {
    return HomeState(
      isFailure: false,
      isLoadingOngs: false,
      isSucess: true,
      ongs: ongs,
      usuario: usuario,
    );
  }
}
