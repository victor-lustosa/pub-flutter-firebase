import 'package:flutter/material.dart';
import '../../establishment/view-models/establishment_view_model.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../../user/view-models/user_view_model.dart';
import '../blocs/user_bloc.dart';
import 'components/age_form_field_widget.dart';
import 'components/dropdown_widget.dart';
import 'components/nickname_form_field_widget.dart';
import 'components/user_register_bar_widget.dart';
import '../../shared/configs/app_routes.dart';
import 'package:provider/provider.dart';

class UserRegisterPage extends StatefulWidget {
  _UserRegisterPageState createState() => _UserRegisterPageState();
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
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Container(
                              width: 350.0,
                              height: 100,
                              child: Form(
                                  key:  context.read<UserViewModel>().formNicknameKey,
                                  child: NicknameFormFieldWidget(
                                      context.read<UserViewModel>().nickNameController)))),
                      Container(
                          width: 350.0,
                          height: 100,
                          child: Form(
                              key:  context.read<UserViewModel>().formAgeKey,
                              child: AgeFormFieldWidget(
                                  context.read<UserViewModel>().ageController))),
                      Container(
                          width: 350,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: new Border.all(
                                color: Colors.black12,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              child: DropdownWidget(
                                context.read<UserViewModel>().genres,
                                (String value) {
                                  setState(() {
                                    context.read<UserViewModel>().selectedGenre = value;
                                  });
                                },
                                "gênero",
                              ))),
                      Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (context.read<UserViewModel>().formNicknameKey.currentState!.validate() &&
                                  context.read<UserViewModel>().formAgeKey.currentState!.validate()) {

                                  context.read<EstablishmentViewModel>().user = context.read<UserViewModel>().saveUser();

                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.establishmentRoute,
                                      ModalRoute.withName(AppRoutes.userRegisterRoute));
                              }
                            },
                            icon: Icon(Icons.navigate_next_rounded, color: AppColors.white),
                            label: Text("Avançar", style: AppFonts.userNextButton),
                            style: ButtonStyle(
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                             RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                              backgroundColor: MaterialStateProperty.all(AppColors.lightBrown),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 110, vertical: 11)),
                            )),
                      )
                    ])))));
  }
}
