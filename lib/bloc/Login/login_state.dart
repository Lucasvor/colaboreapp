part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSucessState extends LoginState {
  final User user;

  LoginSucessState(this.user);
}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState(this.message);
}
