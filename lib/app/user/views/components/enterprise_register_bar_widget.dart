import 'package:flutter/material.dart';
import '../../../shared/configs/app_colors.dart';

import '../../../shared/configs/app_fonts.dart';

class EnterpriseRegisterBarWidget extends PreferredSize {
  EnterpriseRegisterBarWidget({super.key})
      : super(
          preferredSize: const Size.fromHeight(325),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: 325,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: AppColors.darkBrown,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 85,
                  ),
                  child: Text(
                    "Primeiro acesso",
                    style: AppFonts.titleFirstAccess,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Text(
                    "Insira seus dados",
                    style: AppFonts.titleInsertData,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 55,
                    right: 60,
                  ),
                  child: Text(
                    "Escolha uma imagem",
                    style: AppFonts.titleChooseImage,
                  ),
                ),
              ],
            ),
          ),
        );
}
