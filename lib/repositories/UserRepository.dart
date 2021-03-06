import 'package:colaboreapp/utils/error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User> createUser(String cpf, String senha, String name) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: cpf + '@colaboreapp.com', password: senha);
      await result.user.updateProfile(displayName: name);
      await result.user.reload();
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
    } on FirebaseAuthException catch (e) {
      String authError = "";
      switch (e.code) {
        case ErrorCodes.ERROR_C0DE_NETWORK_ERROR:
          authError = ErrorMessages.ERROR_C0DE_NETWORK_ERROR;
          break;
        case ErrorCodes.ERROR_USER_NOT_FOUND:
          authError = ErrorMessages.ERROR_USER_NOT_FOUND;
          break;
        case ErrorCodes.ERROR_TOO_MANY_REQUESTS:
          authError = ErrorMessages.ERROR_TOO_MANY_REQUESTS;
          break;
        case ErrorCodes.ERROR_INVALID_EMAIL:
          authError = ErrorMessages.ERROR_INVALID_EMAIL;
          break;
        case ErrorCodes.ERROR_CODE_USER_DISABLED:
          authError = ErrorMessages.ERROR_CODE_USER_DISABLED;
          break;
        case ErrorCodes.ERROR_CODE_WRONG_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WRONG_PASSWORD;
          break;
        case ErrorCodes.ERROR_CODE_EMAIL_ALREADY_IN_USE:
          authError = ErrorMessages.ERROR_CODE_EMAIL_ALREADY_IN_USE;
          break;
        case ErrorCodes.ERROR_OPERATION_NOT_ALLOWED:
          authError = ErrorMessages.ERROR_OPERATION_NOT_ALLOWED;
          break;
        case ErrorCodes.ERROR_CODE_WEAK_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WEAK_PASSWORD;
          break;
        default:
          authError = ErrorMessages.DEFAULT;
          break;
      }
      throw Exception(authError);
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
