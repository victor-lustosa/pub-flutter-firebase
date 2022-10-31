import 'package:flutter/material.dart';
import 'package:pub/app/shared/components/id_util.dart';
import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../shared/configs/app_routes.dart';
import '../../user/infra/models/user_model.dart';

import 'package:geolocator/geolocator.dart';

import '../blocs/user_bloc.dart';

abstract class IUserViewModel {
  // currentPosition();
}

class UserViewModel implements IUserViewModel {
  UserViewModel({required this.bloc});

  final UserBloc bloc;
  late UserModel user;
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final formAgeKey = GlobalKey<FormState>();
  final formNicknameKey = GlobalKey<FormState>();
  String selectedGenre = '';
  bool isEnabled = true;
  int age = 0;
  final List<String> genres = ['não informado', 'masculino', 'feminino'];

  Future<void> checkUser(context, user) async {
    if (user != null) {
      Navigator.pushReplacementNamed(
          context, AppRoutes.establishmentRoute,
          arguments: EstablishmentDTO(user!));
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    }
  }

  void saveUser() {
    if (ageController.text.isNotEmpty && nickNameController.text.isNotEmpty) {
      age = int.tryParse(ageController.text)!;
      if (age >= 18) {
        if (selectedGenre == '') selectedGenre = genres[0];
        user = UserModel.empty();
        user = user.copyWith(
            idUser: IdUtil.generateRandomString(),
            age: age,
            genre: selectedGenre,
            nickname: nickNameController.text.trimLeft().trimRight());
      }
    }
    bloc.add(SaveUserEvent(user));
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
