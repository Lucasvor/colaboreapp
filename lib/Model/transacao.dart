import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transacao.g.dart';

@JsonSerializable(explicitToJson: true)
class Transacao extends Equatable {
  final String nome;
  final String cpf;
  final double valor;
  final String nomeOng;
  final String cnpj;
  final DateTime dataHora;

  Transacao(
      this.nome, this.cpf, this.valor, this.nomeOng, this.cnpj, this.dataHora);

  @override
  List<Object> get props => [nome, cpf, valor, nomeOng, cnpj, dataHora];

  factory Transacao.fromJson(Map<String, dynamic> json) =>
      _$TransacaoFromJson(json);

  Map<String, dynamic> toJson() => _$TransacaoToJson(this);
}
