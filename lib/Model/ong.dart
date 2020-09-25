import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ong.g.dart';

@JsonSerializable(explicitToJson: true)
class Ong extends Equatable {
  String nome;
  String idDocument;
  String imageUrl;
  String info;
  String cnpj;
  String endereco;
  double latitude;
  double longitude;
  String telefone;
  double valorRecebido;

  Ong(
      {this.idDocument,
      this.cnpj,
      this.endereco,
      this.latitude,
      this.longitude,
      this.telefone,
      this.valorRecebido,
      this.info,
      this.nome,
      this.imageUrl});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  factory Ong.fromJson(Map<String, dynamic> json) => _$OngFromJson(json);

  Map<String, dynamic> toJson() => _$OngToJson(this);
}
