import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evento.g.dart';

@JsonSerializable(explicitToJson: true)
class Evento extends Equatable {
  String ong;
  DateTime data;
  String mensagem;

  Evento({this.ong, this.data, this.mensagem});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  factory Evento.fromJson(Map<String, dynamic> json) => _$EventoFromJson(json);

  Map<String, dynamic> toJson() => _$EventoToJson(this);
}
