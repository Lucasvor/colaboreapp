import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeOngForm extends StatefulWidget {
  final UserRepository userRepository;
  final User usuario;

  const HomeOngForm({Key key, this.userRepository, this.usuario})
      : super(key: key);

  @override
  _HomeOngFormState createState() => _HomeOngFormState();
}

class _HomeOngFormState extends State<HomeOngForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      child: Center(
        child: Text('Home ONG'),
      ),
    );
  }
}
