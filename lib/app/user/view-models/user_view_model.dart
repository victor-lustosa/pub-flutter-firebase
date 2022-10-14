import 'dart:convert';

import 'package:flutter/material.dart';
import '../../user/infra/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import '../../shared/configs/app_routes.dart';
import '../../establishment/infra/models/dto/establishment_dto.dart';

abstract class IUserViewModel {
  // currentPosition();
  void validateUser(
      TextEditingController _nickNameController,
      TextEditingController _ageController,
      String _selectedGenre,
      List<String> _genres);
}

class UserViewModel implements IUserViewModel {
  late final UserModel _user;
  int _age = 0;


  Future<void> checkUser(BuildContext context) async {
    final shared = await SharedPreferences.getInstance();
    final data = shared.getString('user');
    if (data != null) {
      UserModel user = UserModel.fromMap(jsonDecode(data));
      Navigator.pushReplacementNamed(context, AppRoutes.establishmentRoute,
          arguments: EstablishmentDTO(user));
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    }
  }

  void validateUser(
      TextEditingController _nickNameController,
      TextEditingController _ageController,
      String _selectedGenre,
      List<String> _genres) {
    this.getUser.setNickname(_nickNameController.text.trimLeft().trimRight());
    setAge(int.tryParse(_ageController.text)!);
    this.getUser.setAge(getAge);
    if (_selectedGenre == '') {
      _selectedGenre = _genres[0];
      this.getUser.setGenre(_selectedGenre);
    } else {
      this.getUser.setGenre(_selectedGenre);
    }
    saveUser(this.getUser);
  }

  saveUser(UserModel user) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      shared.setString('user', UserModel.toJson(user));
    } catch (e) {
      throw Exception("Erro ao salvar usuario: $e");
    }
  }

  checkAccessToLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('erro na permissão da geolocalização')));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('erro na permissão da geolocalização')));
      }
    }
  }

  get getAge => _age;
  get getUser => _user;

  setAge(int value) => _age = value;
  setUser(UserModel value) => _user = value;
}

  /* modelo pra fazer o modal de icones*/
  // void _showMyDialog(BuildContext context, String message) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Alerta'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('${message}'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('concordo'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  // void saveLocation() {
  //   _userViewModel.locationData.latitude!;
  //   _userViewModel.locationData.longitude!;
  // }