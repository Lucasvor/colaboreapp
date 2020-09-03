// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return Usuario(
    nome: json['nome'] as String,
    email: json['email'] as String,
    senha: json['senha'] as String,
    cpf: json['cpf'] as String,
    dataNascimento: json['dataNascimento'] == null
        ? null
        : DateTime.parse(json['dataNascimento'] as String),
    telefone: json['telefone'] as String,
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'senha': instance.senha,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
      'telefone': instance.telefone,
    };
