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
      dataNascimento: DateTime.parse(res.data()['dataNascimento']),
      nome: res.data()['nome'],
      email: res.data()['email'],
      telefone: res.data()['telefone'],
      face: res.data()['face'],
    );
  }

  Future<void> SetFace(String cpf, int face) async {
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
    await usuarioCollection.doc(cpf).update({
      'face': 'face$face',
      'imageUrl': images.firstWhere((element) => element.contains('face$face'))
    });
  }
}
