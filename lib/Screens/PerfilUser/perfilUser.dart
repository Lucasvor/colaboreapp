import 'package:colaboreapp/Screens/PerfilUser/perfilUserForm.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilUser extends StatelessWidget {
  final UserRepository userRepository;
  final User usuario;
  final String face;

  const PerfilUser({Key key, this.userRepository, this.usuario, this.face})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PerfilUserForm(
        userRepository: userRepository,
        usuario: usuario,
        face: face,
      ),
    );
  }
}
