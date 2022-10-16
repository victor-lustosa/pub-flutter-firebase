import 'package:flutter/material.dart';
import '../../shared/configs/app_colors.dart';
import 'package:pub/app/user/view-models/user_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/age_form_field_widget.dart';
import 'components/dropdown_widget.dart';
import 'components/nickname_form_field_widget.dart';
import 'components/user_register_bar_widget.dart';
import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../shared/configs/app_routes.dart';

class UserRegisterPage extends StatefulWidget {
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  late final UserViewModel _userViewModel;

  @override
  void initState() {
    _userViewModel = UserViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userViewModel.checkAccessToLocation(context);
    });
    super.initState();
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
                                  key: _userViewModel.formNicknameKey,
                                  child: NicknameFormFieldWidget(
                                      _userViewModel.nickNameController)))),
                      Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
                              width: 350.0,
                              height: 100,
                              child: Form(
                                  key: _userViewModel.formAgeKey,
                                  child: AgeFormFieldWidget(
                                      _userViewModel.ageController)))),
                      Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
                              width: 350,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                border: new Border.all(
                                    color: Colors.black12,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              child: Form(
                                  autovalidateMode: AutovalidateMode.always,
                                  child: DropdownWidget(
                                    _userViewModel.getGenres,
                                    (String value) {
                                      setState(() {
                                        _userViewModel.selectedGenre = value;
                                      });
                                    },
                                    "gênero",
                                  )))),
                      Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (_userViewModel.formNicknameKey.currentState!
                                      .validate() &&
                                  _userViewModel.formAgeKey.currentState!
                                      .validate()) {

                                _userViewModel.validateUser();
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.establishmentRoute,
                                    ModalRoute.withName(
                                        AppRoutes.userRegisterRoute),
                                    arguments: EstablishmentDTO(
                                        _userViewModel.getUser));
                              }
                            },
                            icon: Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.white,
                            ),
                            label: Text("Avançar",
                                style: GoogleFonts.inter(
                                    fontSize: 15, color: Colors.white)),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)))),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.lightBrown),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 110, vertical: 11)),
                            )),
                      )
                    ])))));
  }
}
