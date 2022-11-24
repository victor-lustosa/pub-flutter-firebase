import 'package:flutter/material.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/views/user_register_page.dart';
import '../../shared/configs/app_images.dart';

//todo: arrumar o renderflex quando entra no forms, aparece o teclado
//todo: e clica em voltar
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBarWidget(context),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.darkBrown,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 350),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserRegisterPage(),
                      ),
                    );
                  },
                  label: Text(
                    "Cadastrar",
                    style: AppFonts.registerButton,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.lightBrown),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 13,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.account_circle,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
