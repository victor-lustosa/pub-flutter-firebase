import 'package:flutter/material.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/views/user_register_page.dart';

import 'components/home_bar_widget.dart';
//todo: arrumar o renderflex quando entra no forms, aparece o teclado
//todo: e clica em voltar
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeBarWidget(context),
        body: Container(
          decoration: BoxDecoration(color: AppColors.darkBrown),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 350),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserRegisterPage()));
                    },
                    label: Text("Cadastrar",
                        style: AppFonts.registerButton),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.lightBrown),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 100, vertical: 13)),
                    ),
                    icon: Icon(
                      Icons.account_circle,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
