part of 'cadastro_bloc.dart';

abstract class CadastroEvent extends Equatable {
  const CadastroEvent();

  @override
  List<Object> get props => [];
}

//cadastroFormOng

class CadastroNomeFantasiaChanged extends CadastroEvent {
  final String nomeFantasia;

  CadastroNomeFantasiaChanged(this.nomeFantasia);
  @override
  List<Object> get props => [];
}

class CadastroCnpjChanged extends CadastroEvent {
  final String cnpj;

  CadastroCnpjChanged(this.cnpj);
  @override
  List<Object> get props => [];
}

class CadastroDataRegistroChanged extends CadastroEvent {
  final String dataRegistro;

  CadastroDataRegistroChanged(this.dataRegistro);
  @override
  List<Object> get props => [];
}

class CadastroCategoriaChanged extends CadastroEvent {
  final String categoria;

  CadastroCategoriaChanged(this.categoria);
  @override
  List<Object> get props => [];
}

class CadastroCpfChanged extends CadastroEvent {
  final String cpf;

  CadastroCpfChanged(this.cpf);

  @override
  List<Object> get props => [];
}

class CadastroTelChanged extends CadastroEvent {
  final String telefone;

  CadastroTelChanged(this.telefone);
  @override
  List<Object> get props => [];
}

//cadastroFromSenha

class CadastroSenhaChanged extends CadastroEvent {
  final String senha;

  CadastroSenhaChanged(this.senha);
  @override
  List<Object> get props => [];
}

class CadastroConfirmaSenhaChanged extends CadastroEvent {
  final String confirmaSenha;

  CadastroConfirmaSenhaChanged(this.confirmaSenha);
  @override
  List<Object> get props => [];
}

class CadastroSubmitted extends CadastroEvent {
  final String cpf;
  final String senha;
  final String nome;
  final String confirmaSenha;

  CadastroSubmitted(
      {this.cpf,
      this.senha,
      this.nome,
      this.confirmaSenha,
      categoriaOng,
      dataRegistroOng,
      telOng,
      String cnpjOng,
      String nomeFantasiaOng});

  @override
  List<Object> get props => [];
}
