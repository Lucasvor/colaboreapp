import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Senha",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColorGreen,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColorGreen,
          ),
          //border: InputBorder.none
        ),
      ),
    );
  }
}
