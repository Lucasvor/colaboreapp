import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String password;
  final TextEditingController textEditingController;

  const PasswordField({
    Key key,
    this.onChanged,
    this.password,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPass = true;
    return TextFieldContainer(
      child: TextField(
        controller: textEditingController,
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
