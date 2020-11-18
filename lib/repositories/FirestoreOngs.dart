import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colaboreapp/Model/evento.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/ongCadastro.dart';
import 'package:colaboreapp/Model/transacao.dart';
import 'package:colaboreapp/Model/usuario.dart';

class FirestoreOngs {
  final ongsCollection = FirebaseFirestore.instance.collection("ongs");
  final transacoes = FirebaseFirestore.instance.collection("transacoes");
  final eventos = FirebaseFirestore.instance.collection("eventos");

  final pictures = FirebaseFirestore.instance.collection("pictures");

  Future<List<Ong>> allOngs() async {
    var qshot = await ongsCollection.get();

    return qshot.docs
        .map(
          (e) => Ong(
            idDocument: e.id,
            nome: e.data()['nome'],
            categoria: e.data()['categoria'],
            dataRegistro: e.data()['dataRegistro'],
            senha: e.data()['senha'],
            imageUrl: e.data()['imageUrl'],
            info: e.data()['info'],
            cnpj: e.data()['cnpj'],
            endereco: e.data()['endereco'],
            latitude: e.data()['latitude'],
            longitude: e.data()['longitude'],
            telefone: e.data()['telefone'],
            valorRecebido: reciprocal(e.data()['valorRecebido']),
          ),
        )
        .toList();
  }

  Future<void> makeEvento(Evento evento) async {
    return eventos.doc().set(evento.toJson());
  }

  Future<Ong> getOng(String cnpj) async {
    var qshot = await ongsCollection.where('cnpj', isEqualTo: cnpj).get();
    try {
      return qshot.docs
          .map(
            (e) => Ong(
              idDocument: e.id,
              nome: e.data()['nome'],
              categoria: e.data()['categoria'],
              dataRegistro: e.data()['dataRegistro'],
              senha: e.data()['senha'],
              imageUrl: e.data()['imageUrl'],
              info: e.data()['info'],
              cnpj: e.data()['cnpj'],
              endereco: e.data()['endereco'],
              latitude: e.data()['latitude'],
              longitude: e.data()['longitude'],
              telefone: e.data()['telefone'],
              valorRecebido: reciprocal(e.data()['valorRecebido']),
            ),
          )
          .toList()
          .first;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addNewOng(Ong userOng) async {
    print(userOng.toJson());
    return ongsCollection.doc(userOng.cnpj).set(userOng.toJson());
  }

  Future<List<Transacao>> getTransacoesDoador(String cpf) async {
    var qtran = await transacoes.where('cpf', isEqualTo: cpf).get();
    try {
      return qtran.docs
          .map(
            (e) => Transacao(
                e.data()['nome'],
                e.data()['cpf'],
                e.data()['valor'],
                e.data()['nomeOng'],
                e.data()['cnpj'],
                timestamptoDate(e.data()['dataHora'])),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Transacao>> getTransacaoOng(String cnpj) async {
    var qtran = await transacoes.where('cpnj', isEqualTo: cnpj).get();
    try {
      return qtran.docs
          .map(
            (e) => Transacao(
                e.data()['nome'],
                e.data()['cpf'],
                e.data()['valor'],
                e.data()['nomeOng'],
                e.data()['cnpj'],
                timestamptoDate(e.data()['dataHora'])),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Evento>> getEventos() async {
    var qeventos = await eventos.get();
    try {
      return qeventos.docs
          .map(
            (e) => Evento(
              ong: e.data()['ong'],
              mensagem: e.data()['mensagem'],
              data: timestamptoDate(
                e.data()['data'],
              ),
            ),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addValorDoacao(
      Ong ong, double valor, String cpf, String nome) async {
    try {
      var tran =
          new Transacao(nome, cpf, valor, ong.nome, ong.cnpj, DateTime.now());
      print(tran.toJson());
      ong.valorRecebido = ong.valorRecebido + valor;
      print(ong.toJson());
      ongsCollection.doc(ong.idDocument).set(ong.toJson());
      transacoes.doc().set(tran.toJson());
      return true;
    } catch (x) {
      return false;
    }
  }

  Future<void> setImages() async {
    List<String> images = [
      "https://i.ibb.co/hm1BWwq/face0.jpg",
      "https://i.ibb.co/cNGwWcW/face1.jpg",
      "https://i.ibb.co/YBqnL3R/face2.jpg",
      "https://i.ibb.co/p2HR5WW/face3.jpg",
      "https://i.ibb.co/wBgQfDb/face4.jpg",
      "https://i.ibb.co/rFxNBfQ/face5.jpg",
      "https://i.ibb.co/r3kcFsh/face6.jpg",
      "https://i.ibb.co/T1VHTny/face7.jpg",
      "https://i.ibb.co/42sfwHc/face8.jpg",
      "https://i.ibb.co/mDrL2Hn/face9.jpg",
      "https://i.ibb.co/56ZMYcS/face10.jpg",
      "https://i.ibb.co/dfnpKvQ/face11.jpg",
      "https://i.ibb.co/mDsVyC7/face12.jpg",
      "https://i.ibb.co/G76Qymb/face13.jpg",
      "https://i.ibb.co/4WfXTPT/face14.jpg",
      "https://i.ibb.co/MBrYfG5/face15.jpg",
      "https://i.ibb.co/pbm1hvg/face16.jpg",
      "https://i.ibb.co/4YcwHgF/face17.jpg",
      "https://i.ibb.co/j3MGX4G/face18.jpg",
      "https://i.ibb.co/cXw5wWz/face19.jpg",
      "https://i.ibb.co/5kNf0h7/face20.jpg"
    ];
    for (var item in images) {
      pictures.add({
        'imageUrl': item,
        'face': item.split('/').last.replaceAll(".jpg", "")
      }).then((value) => print("Imagem criada: $item"));
    }
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

double reciprocal(num value) {
  return value.toDouble();
}

DateTime timestamptoDate(String t) {
  return DateTime.parse(t);
}
