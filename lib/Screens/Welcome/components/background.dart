import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: SvgPicture.asset(
              "assets/images/Planet.svg",
              width: size.width * 0.5,
              color: kBackgroundColor,
            ),
          ),
          Positioned(
            bottom: (size.height / 2 * .55),
            child: Text(
              "Pois o Mundo precisa de você",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Colors.black.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
