part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginEvent {
  final String cpf;
  final String senha;

  LoginButtonPressedEvent(this.cpf, this.senha);
}
