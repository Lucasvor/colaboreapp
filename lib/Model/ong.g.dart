// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ong _$OngFromJson(Map<String, dynamic> json) {
  return Ong(
    info: json['info'] as String,
    nome: json['nome'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$OngToJson(Ong instance) => <String, dynamic>{
      'nome': instance.nome,
      'imageUrl': instance.imageUrl,
      'info': instance.info,
    };
