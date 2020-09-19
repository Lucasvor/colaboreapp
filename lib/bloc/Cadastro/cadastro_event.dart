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
  List<Object> get props => [nomeFantasia];
}

class CadastroCnpjChanged extends CadastroEvent {
  final String cnpj;

  CadastroCnpjChanged(this.cnpj);
  @override
  List<Object> get props => [cnpj];
}

class CadastroDataRegistroChanged extends CadastroEvent {
  final String dataRegistro;

  CadastroDataRegistroChanged(this.dataRegistro);
  @override
  List<Object> get props => [dataRegistro];
}

class CadastroCategoriaChanged extends CadastroEvent {
  final String categoria;

  CadastroCategoriaChanged(this.categoria);
  @override
  List<Object> get props => [categoria];
}

class CadastroCpfChanged extends CadastroEvent {
  final String cpf;

  CadastroCpfChanged(this.cpf);

  @override
  List<Object> get props => [cpf];
}

class CadastroEmailChanged extends CadastroEvent {
  final String email;

  CadastroEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class CadastroDateChanged extends CadastroEvent {
  final String date;

  CadastroDateChanged(this.date);

  @override
  List<Object> get props => [date];
}

class CadastroTelChanged extends CadastroEvent {
  final String telefone;

  CadastroTelChanged(this.telefone);
  @override
  List<Object> get props => [telefone];
}

//cadastroFromSenha

class CadastroSenhaChanged extends CadastroEvent {
  final String senha;

  CadastroSenhaChanged(this.senha);
  @override
  List<Object> get props => [senha];
}

class CadastroPageSenha extends CadastroEvent {
  @override
  List<Object> get props => null;
}

class CadastroSubmitted extends CadastroEvent {
  final String cpf;
  final String senha;
  final String nome;
  final String telefone;
  final String dataNascimento;
  final String email;

  CadastroSubmitted({
    this.cpf,
    this.senha,
    this.nome,
    this.telefone,
    this.dataNascimento,
    this.email,
  });

  @override
  List<Object> get props => [
        cpf,
        senha,
        nome,
        telefone,
        dataNascimento,
        email,
      ];
}
