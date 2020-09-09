import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ong.g.dart';

@JsonSerializable(explicitToJson: true)
class Ong extends Equatable {
  final String nome;
  final String imageUrl;

  Ong({this.nome, this.imageUrl});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  factory Ong.fromJson(Map<String, dynamic> json) => _$OngFromJson(json);

  Map<String, dynamic> toJson() => _$OngToJson(this);
}
