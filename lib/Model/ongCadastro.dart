import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongCadastro.g.dart';

@JsonSerializable(explicitToJson: true)
class OngCadastro extends Equatable {
  final String nome;
  final String imageUrl;
  final String info;
  final String cnpj;
  final String telefone;
  final String dataRegistro;
  final String categoria;
  final String senha;

  OngCadastro(
    @required this.cnpj,
    this.telefone,
    this.dataRegistro,
    this.categoria, {
    this.info,
    this.nome,
    this.imageUrl,
    @required this.senha,
  });

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  factory OngCadastro.fromJson(Map<String, dynamic> json) =>
      _$OngCadastroFromJson(json);

  Map<String, dynamic> toJson() => _$OngCadastroToJson(this);
}
