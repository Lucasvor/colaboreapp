import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/ongCadastro.dart';

class FirestoreOngs {
  final ongsCollection = FirebaseFirestore.instance.collection("ongs");

  Future<List<Ong>> allOngs() async {
    var qshot = await ongsCollection.get();

    return qshot.docs
        .map((e) => Ong(
            nome: e.data()['nome'],
            imageUrl: e.data()['imageUrl'],
            info: e.data()['info']))
        .toList();
  }

  Future<void> addNewOng(OngCadastro userOng) async {
    print(userOng.toJson());
    return ongsCollection.doc(userOng.cnpj).set(userOng.toJson());
  }
}
