part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginDocumentChange extends LoginEvent {
  final String documento;

  LoginDocumentChange({this.documento});
  @override
  List<Object> get props => [documento];
}

class LoginSenhaChange extends LoginEvent {
  final String senha;

  LoginSenhaChange({this.senha});

  @override
  List<Object> get props => [senha];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String documento;
  final String senha;

  LoginWithCredentialsPressed({this.documento, this.senha});

  @override
  List<Object> get props => [documento, senha];
}

class LoginButtonPressedEvent extends LoginEvent {
  final String cpf;
  final String senha;

  LoginButtonPressedEvent(this.cpf, this.senha);
}
