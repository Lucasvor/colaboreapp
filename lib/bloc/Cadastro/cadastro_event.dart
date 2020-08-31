part of 'cadastro_bloc.dart';

abstract class CadastroEvent extends Equatable {
  const CadastroEvent();

  @override
  List<Object> get props => [];
}

class CadastroCpfChanged extends CadastroEvent {
  final String cpf;

  CadastroCpfChanged(this.cpf);

  @override
  List<Object> get props => [];
}

class CadastroSenhaChanged extends CadastroEvent {
  final String senha;

  CadastroSenhaChanged(this.senha);
  @override
  List<Object> get props => [];
}

class CadastroSubmitted extends CadastroEvent {
  final String cpf;
  final String senha;
  final String nome;

  CadastroSubmitted({this.cpf, this.senha, this.nome});

  @override
  List<Object> get props => [];
}
