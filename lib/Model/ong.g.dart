// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ong _$OngFromJson(Map<String, dynamic> json) {
  return Ong(
    idDocument: json['idDocument'] as String,
    cnpj: json['cnpj'] as String,
    endereco: json['endereco'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    telefone: json['telefone'] as String,
    valorRecebido: (json['valorRecebido'] as num)?.toDouble(),
    info: json['info'] as String,
    nome: json['nome'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$OngToJson(Ong instance) => <String, dynamic>{
      'nome': instance.nome,
      'idDocument': instance.idDocument,
      'imageUrl': instance.imageUrl,
      'info': instance.info,
      'cnpj': instance.cnpj,
      'endereco': instance.endereco,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'telefone': instance.telefone,
      'valorRecebido': instance.valorRecebido,
    };
