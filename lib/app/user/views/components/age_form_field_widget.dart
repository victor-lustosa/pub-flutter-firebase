import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/configs/app_fonts.dart';

class AgeFormFieldWidget extends StatelessWidget {
  const AgeFormFieldWidget(this.formFieldController, {super.key});

  final TextEditingController formFieldController;

  String? validateFormField(value) {
    int valor = 0;
    if (value != '') {
      valor = int.tryParse(value)!;
    }

    if (value == "") {
      return "digite sua idade";
    } else if (valor < 18) {
      return "Precisa ser maior de 18 anos";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      height: 100,
      child: TextFormField(
        onEditingComplete: () {},
        onChanged: validateFormField,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: false,
        maxLength: 2,
        validator: validateFormField,
        controller: formFieldController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 30,
          ),
          focusColor: Colors.black12,
          hintText: 'idade',
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
        style: AppFonts.formAge,
      ),
    );
  }
}
