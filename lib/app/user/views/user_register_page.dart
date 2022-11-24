import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../establishment/view-models/establishment_view_model.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../../user/view-models/user_view_model.dart';

import '../../shared/components/dropdown_widget.dart';

import '../../shared/configs/app_routes.dart';
import 'package:provider/provider.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().checkAccessToLocation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: UserRegisterBarWidget(context),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: SizedBox(
                    width: 350.0,
                    height: 100,
                    child: Form(
                      key: context.read<UserViewModel>().formNicknameKey,
                      child: NicknameFormFieldWidget(
                        context.read<UserViewModel>().nickNameController,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 350.0,
                  height: 100,
                  child: Form(
                    key: context.read<UserViewModel>().formAgeKey,
                    child: AgeFormFieldWidget(
                      context.read<UserViewModel>().ageController,
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: DropdownWidget(
                      context.read<UserViewModel>().genres,
                      (String value) {
                        setState(
                          () {
                            context.read<UserViewModel>().selectedGenre = value;
                          },
                        );
                      },
                      "gênero",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (context
                              .read<UserViewModel>()
                              .formNicknameKey
                              .currentState!
                              .validate() &&
                          context
                              .read<UserViewModel>()
                              .formAgeKey
                              .currentState!
                              .validate()) {
                        context.read<EstablishmentViewModel>().user =
                            context.read<UserViewModel>().saveUser();

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.establishmentRoute,
                          ModalRoute.withName(AppRoutes.userRegisterRoute),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.white,
                    ),
                    label: Text(
                      "Avançar",
                      style: AppFonts.userNextButton,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.lightBrown,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 110,
                          vertical: 11,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
