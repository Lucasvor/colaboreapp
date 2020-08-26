import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String password;

  const PasswordField({
    Key key,
    this.onChanged,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPass = true;
    return TextFieldContainer(
      child: TextField(
        obscureText: showPass,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Senha",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColorGreen,
          ),
          suffixIcon: IconButton(
              icon: Icon(Icons.visibility),
              color: kPrimaryColorGreen,
              onPressed: () => {
                    showPass = !showPass,
                    print(showPass),
                  }),

          //border: InputBorder.none
        ),
      ),
    );
  }
}
