import 'package:colaboreapp/Screens/Welcome/Splash.dart';
import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colabore APP',
      theme: ThemeData(
        primaryColor: kPrimaryColorGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Splash(),
    );
  }
}
