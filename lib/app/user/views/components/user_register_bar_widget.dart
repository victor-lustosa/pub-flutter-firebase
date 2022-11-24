import 'package:flutter/material.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../shared/configs/app_fonts.dart';

class UserRegisterBarWidget extends PreferredSize {
  UserRegisterBarWidget(BuildContext context, {super.key})
      : super(
          preferredSize: const Size.fromHeight(325),
          child: Container(
            height: 325,
            decoration: const BoxDecoration(
              color: AppColors.darkBrown,
            ),
            child: Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 160,
                        left: 5,
                      ),
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          color: AppColors.white,
                        ),
                        color: AppColors.darkBrown,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100,
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
                // Padding(padding: EdgeInsets.only(top: 200, right: 30),
                //     child:Text("Escolha uma imagem",
                //         style:AppFonts.titleChooseImage
                //     )
                // ),Padding(padding: EdgeInsets.only(left: 180, top: 175), child: IconButton(
                //   icon: const Icon(Icons.account_circle,size: 60),
                //   color: Colors.white,
                //   onPressed: () {},
                // ),)
              ],
            ),
          ),
        );
}
