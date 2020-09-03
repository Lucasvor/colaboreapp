import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colaboreapp/Model/usuario.dart';

class FirestoreUserRepository {
  final usuarioCollection = FirebaseFirestore.instance.collection("usuarios");

  Future<void> addNewUsuario(Usuario usuario) async {
    print(usuario.toJson());
    return usuarioCollection.doc(usuario.cpf).set(usuario.toJson());
  }
}
