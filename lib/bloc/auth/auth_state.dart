part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSplashState extends AuthState {}

// ignore: must_be_immutable
class AuthSucessState extends AuthState {
  final User user;
  AuthSucessState({@required this.user});
  @override
  List<Object> get props => [user];
}

class AuthSucessStateOng extends AuthState {
  final User user;
  AuthSucessStateOng({@required this.user});
  @override
  List<Object> get props => [user];
}

class UnAuthState extends AuthState {}

class AuthErrorState extends AuthState {
  final String mensagem;

  AuthErrorState(this.mensagem);
}
