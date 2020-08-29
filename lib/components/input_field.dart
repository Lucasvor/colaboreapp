import 'package:colaboreapp/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  const InputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColorGreen,
          ),
          hintText: hintText,
          //border: InputBorder.none se quiser tirar a linha
        ),
        onChanged: onChanged,
      ),
    );
  }
}
