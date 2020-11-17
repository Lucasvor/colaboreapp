// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evento _$EventoFromJson(Map<String, dynamic> json) {
  return Evento(
    ong: json['ong'] as String,
    data: json['data'] == null ? null : DateTime.parse(json['data'] as String),
    mensagem: json['mensagem'] as String,
  );
}

Map<String, dynamic> _$EventoToJson(Evento instance) => <String, dynamic>{
      'ong': instance.ong,
      'data': instance.data?.toIso8601String(),
      'mensagem': instance.mensagem,
    };
