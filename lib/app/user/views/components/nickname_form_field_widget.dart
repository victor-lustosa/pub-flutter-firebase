import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/configs/app_fonts.dart';

class NicknameFormFieldWidget extends StatelessWidget {
  const NicknameFormFieldWidget(this.formFieldController, {super.key});

  final TextEditingController formFieldController;

  String? validateFormField(value) {
    if (value == null || value.isEmpty) {
      return "digite seu nickname";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {},
      onChanged: validateFormField,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      maxLength: 40,
      validator: validateFormField,
      controller: formFieldController,
      keyboardType: TextInputType.text,
      inputFormatters: const <TextInputFormatter>[],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 30,
        ),
        focusColor: Colors.black12,
        hintText: 'nickname',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      style: AppFonts.formNickname,
    );
  }
}
