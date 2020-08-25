import 'package:colaboreapp/Screens/Login/login_screen.dart';
import 'package:colaboreapp/components/rounded_button.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.8),
            RoundedButton(
              text: "Proxima Tela",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
