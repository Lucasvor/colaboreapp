import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/ongCadastro.dart';

class FirestoreOngs {
  final ongsCollection = FirebaseFirestore.instance.collection("ongs");

  Future<List<Ong>> allOngs() async {
    var qshot = await ongsCollection.get();

    return qshot.docs
        .map(
          (e) => Ong(
            idDocument: e.id,
            nome: e.data()['nome'],
            imageUrl: e.data()['imageUrl'],
            info: e.data()['info'],
            cnpj: e.data()['cnpj'],
            endereco: e.data()['endereco'],
            latitude: e.data()['latitude'],
            longitude: e.data()['longitude'],
            telefone: e.data()['telefone'],
            valorRecebido: e.data()['valorRecebido'],
          ),
        )
        .toList();
  }

  Future<void> addNewOng(OngCadastro userOng) async {
    print(userOng.toJson());
    return ongsCollection.doc(userOng.cnpj).set(userOng.toJson());
  }

  Future<void> setOng(List<Ong> ongs) async {
    for (var item in ongs) {
      if (item.cnpj == "77596050000101") {
        item.endereco =
            "Av. Inocêncio Seráfico, 3500 - Vila Dirce, Carapicuíba - SP, 06380-021";
        item.latitude = -23.552787;
        item.longitude = -46.835511;
        item.telefone = "(11) 4374-2030";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "23502911000112") {
        item.endereco = "Av. Angélica, 2529";
        item.latitude = -23.554154;
        item.longitude = -46.662237;
        item.telefone = "(11) 97264-0403";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "38894796000146") {
        item.endereco = "Avenida Santo Amaro, 1.386 - 1º Andar";
        item.latitude = -23.596151;
        item.longitude = 46.673730;
        item.telefone = "0300 10 12345";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "40358848000101") {
        item.endereco = "Rua das Palmeiras, 65 – Botafogo";
        item.latitude = -22.952295;
        item.longitude = -43.190975;
        item.telefone = "(21)  22869988 / 30821632";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "00343941000128") {
        item.endereco = "Rua Alberto de Campos, 12 - Ipanema";
        item.latitude = -22.981056;
        item.longitude = -43.199074;
        item.telefone = "21 2555-3750";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "02744697000130") {
        item.endereco = "Rua Faro, 80 – anexo 2º andar";
        item.latitude = -22.962284;
        item.longitude = -43.219116;
        item.telefone = "(21)2239-9555";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "60979457000111") {
        item.endereco =
            "Av. Professor Ascendino Reis, 724 - Ibirapuera – São Paulo – SP";
        item.latitude = -23.597009;
        item.longitude = -46.651701;
        item.telefone = "(11) 5576-0777";
        item.valorRecebido = 0;
      }
      if (item.cnpj == "03741616000101") {
        item.endereco = "R. Prof. João Marinho, 161, São Paulo - SP";
        item.latitude = -23.574594;
        item.longitude = -46.652353;
        item.telefone = " (11) 3259-6986 / (11) 95050-4257";
        item.valorRecebido = 0;
      }
      if (item.cnpj == " 00627727000101") {
        item.endereco =
            "SCLN 211, Bloco B, Sala 201, Bairro Asa Norte - Brasília-DF";
        item.latitude = -15.751770;
        item.longitude = -47.886191;
        item.telefone = "(61) 2109-4150/2196-4150";
        item.valorRecebido = 0;
      }

      print(item);
      ongsCollection.doc(item.idDocument).set(item.toJson());
    }
  }
}
