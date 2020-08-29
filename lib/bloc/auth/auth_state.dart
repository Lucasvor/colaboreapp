part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// ignore: must_be_immutable
class AuthenticatedState extends AuthState {
  User user;

  AuthenticatedState({@required this.user});
}

class UnAuthenticatedState extends AuthState {}

class AuthenticatedErrorState extends AuthState {
  final String mensagem;

  AuthenticatedErrorState(this.mensagem);
}
