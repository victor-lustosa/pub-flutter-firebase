import 'package:flutter/material.dart';
import '../../../shared/configs/app_colors.dart';

import '../../../shared/configs/app_fonts.dart';
import '../../../shared/configs/app_images.dart';

class HomeBarWidget extends PreferredSize {
  HomeBarWidget(BuildContext context, {super.key})
      : super(
          preferredSize: const Size.fromHeight(325),
          child: SizedBox(
            height: 325,
            child: Container(
              decoration: const BoxDecoration(color: AppColors.darkBrown),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Image.asset(AppImages.darkLogo,
                        width: 100, height: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text("APP", style: AppFonts.titleAppHome),
                  ),
                ],
              ),
            ),
          ),
        );
}
