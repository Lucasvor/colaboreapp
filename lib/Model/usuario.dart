import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable(explicitToJson: true)
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

  Usuario toEntity() {
    return Usuario(
        cpf: cpf,
        email: email,
        senha: senha,
        nome: nome,
        telefone: telefone,
        dataNascimento: dataNascimento);
  }

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
