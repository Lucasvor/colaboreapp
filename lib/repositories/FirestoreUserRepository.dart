import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colaboreapp/Model/usuario.dart';

class FirestoreUserRepository {
  final usuarioCollection = FirebaseFirestore.instance.collection("usuarios");

  Future<void> addNewUsuario(Usuario usuario) async {
    print(usuario.toJson());
    return usuarioCollection.doc(usuario.cpf).set(usuario.toJson());
  }

  Future<Usuario> GetUser(String cpf) async {
    print(cpf);
    var res = await usuarioCollection.doc(cpf).get();
    return Usuario(
      cpf: res.data()['cpf'],
      senha: res.data()['senha'],
      dataNascimento: res.data()['dataNascimento'],
      nome: res.data()['nome'],
      email: res.data()['email'],
      telefone: res.data()['telefone'],
      face: res.data()['face'],
    );
  }
}
