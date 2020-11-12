// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transacao _$TransacaoFromJson(Map<String, dynamic> json) {
  return Transacao(
    json['nome'] as String,
    json['cpf'] as String,
    (json['valor'] as num)?.toDouble(),
    json['nomeOng'] as String,
    json['cpnj'] as String,
    json['dataHora'] == null
        ? null
        : DateTime.parse(json['dataHora'] as String),
  );
}

Map<String, dynamic> _$TransacaoToJson(Transacao instance) => <String, dynamic>{
      'nome': instance.nome,
      'cpf': instance.cpf,
      'valor': instance.valor,
      'nomeOng': instance.nomeOng,
      'cpnj': instance.cpnj,
      'dataHora': instance.dataHora?.toIso8601String(),
    };
