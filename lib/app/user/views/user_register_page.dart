import 'package:flutter/material.dart';
import '../../shared/configs/app_colors.dart';

import 'package:pub/app/user/view-models/user_view_model.dart';
import '../../shared/components/form_field_widget.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/dropdown_widget.dart';

import '../infra/models/user_model.dart';
import 'components/user_register_bar_widget.dart';
import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../shared/configs/app_routes.dart';

class UserRegisterPage extends StatefulWidget {
  late final UserModel user;


  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  late final UserViewModel _userViewModel;

  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final List<String> _genres = ['não informado', 'masculino', 'feminino'];
  String _selectedGenre = '';
  bool isEnabled = true;
  int age = 0;
  @override
  void initState() {
    _userViewModel = UserViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userViewModel.checkAccessToLocation(context);
      if (widget.user.nickname != '') {
        _nickNameController.text = widget.user.nickname;
        _ageController.text = widget.user.age.toString();
      }
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
                          padding: EdgeInsets.only(top: 60),
                          child: FormFieldWidget(
                            _nickNameController,
                            'nickname',
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: FormFieldWidget(_ageController, 'idade')),
                      Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
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
                              width: 350,
                              height: 55,
                              child: Form(
                                  autovalidateMode: AutovalidateMode.always,
                                  child: DropdownWidget(
                                    _genres,
                                    (String retorno) {
                                      setState(() {
                                        _selectedGenre = retorno;
                                      });
                                    },
                                    "gênero",
                                  )))),
                      Padding(
                        padding: EdgeInsets.only(top: 95),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              age = int.tryParse(_ageController.text) == null
                                  ? 0
                                  : int.tryParse(_ageController.text)!;
                              if (_ageController.text.isNotEmpty &&
                                  _nickNameController.text.isNotEmpty) {
                                if (age >= 18) {
                                  _userViewModel.validateUser(
                                      _nickNameController,
                                      _ageController,
                                      _selectedGenre,
                                      _genres);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.establishmentRoute,
                                      ModalRoute.withName(
                                          AppRoutes.userRegisterRoute),
                                      arguments: EstablishmentDTO(
                                          _userViewModel.getUser));
                                }
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
                                      horizontal: 130, vertical: 14)),
                            )),
                      )
                    ])))));
  }
}
