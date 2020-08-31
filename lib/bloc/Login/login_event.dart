part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCpfChange extends LoginEvent {
  final String cpf;

  LoginCpfChange({this.cpf});
  @override
  List<Object> get props => [cpf];
}

class LoginSenhaChange extends LoginEvent {
  final String senha;

  LoginSenhaChange({this.senha});

  @override
  List<Object> get props => [senha];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String cpf;
  final String senha;

  LoginWithCredentialsPressed({this.cpf, this.senha});

  @override
  List<Object> get props => [cpf, senha];
}

class LoginButtonPressedEvent extends LoginEvent {
  final String cpf;
  final String senha;

  LoginButtonPressedEvent(this.cpf, this.senha);
}
