import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Usuario extends Equatable {
  final String nome;
  final String email;
  final String senha;
  final String cpf;
  final DateTime dataNascimento;
  final String telefone;
  const Usuario({
    this.nome,
    this.email,
    @required this.senha,
    @required this.cpf,
    this.dataNascimento,
    this.telefone,
  });

  static const empty = Usuario(cpf: '', senha: '');
  @override
  // TODO: implement props
  List<Object> get props => [nome, email, senha, cpf, dataNascimento, telefone];
}
