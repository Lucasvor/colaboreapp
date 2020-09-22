part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSplash extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthStarted extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthLoggedIn extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthLoggedInOng extends AuthEvent {
  @override
  List<Object> get props => null;
}

class AuthLoggedOut extends AuthEvent {
  @override
  List<Object> get props => null;
}
