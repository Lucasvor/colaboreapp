// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongCadastro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngCadastro _$OngCadastroFromJson(Map<String, dynamic> json) {
  return OngCadastro(
    json['cnpj'] as String,
    json['telefone'] as String,
    json['dataRegistro'] as String,
    json['categoria'] as String,
    info: json['info'] as String,
    nome: json['nome'] as String,
    imageUrl: json['imageUrl'] as String,
    senha: json['senha'] as String,
  );
}

Map<String, dynamic> _$OngCadastroToJson(OngCadastro instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'imageUrl': instance.imageUrl,
      'info': instance.info,
      'cnpj': instance.cnpj,
      'telefone': instance.telefone,
      'dataRegistro': instance.dataRegistro,
      'categoria': instance.categoria,
      'senha': instance.senha,
    };
