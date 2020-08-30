import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User> createUser(String cpf, String senha) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: cpf + '@colaboreapp.com', password: senha);
      return result.user;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<User> singInUser(String cpf, String senha) async {
    try {
      var result = await firebaseAuth.signInWithEmailAndPassword(
        email: cpf + '@colaboreapp.com',
        password: senha,
      );
      return result.user;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> singOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }
}
