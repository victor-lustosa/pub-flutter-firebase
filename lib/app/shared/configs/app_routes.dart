import 'package:flutter/material.dart';
import 'package:pub/app/participant/models/dto/participant_dto.dart';

import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../establishment/views/establishment_page.dart';
import '../../home/views/home_page.dart';
import '../../participant/views/participant_page.dart';
import '../../room/models/dto/room_dto.dart';
import '../../room/views/room_page.dart';
import '../../user/infra/models/user_model.dart';
import '../../user/views/user_register_page.dart';

const urlServer = 'https://powerful-bayou-46345.herokuapp.com';

// const urlServer = 'http://localhost:4000';
class AppRoutes {
  static const String initialRoute = "/";
  static const String homeRoute = "/home";
  static const String userRegisterRoute = "/user-register";
  static const String editUserRoute = "/edit-user";
  static const String enterpriseRegisterRoute = "/enterprise-register";
  static const String establishmentRoute = "/establishments";
  static const String publicRoomRoute = "/public-room";
  static const String privateRoomRoute = "/private-room";

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {

    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case initialRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case establishmentRoute:
        return MaterialPageRoute(
            // builder: (_) => EstablishmentPage(establishmentDTO.getUser, establishmentDTO.getEstablishment));
            builder: (_) => EstablishmentPage((arguments as EstablishmentDTO).getUser));

      case userRegisterRoute:
        return MaterialPageRoute(
            builder: (_) => UserRegisterPage());

      // case ENTERPRISE_REGISTER_ROUTE:
      //   return MaterialPageRoute(
      //       builder: (_) =>  EnterpriseRegisterPage());
      case editUserRoute:
        return MaterialPageRoute(builder: (_) => UserRegisterPage());

      case publicRoomRoute:
        return MaterialPageRoute(
            builder: (_) => RoomPage((arguments as RoomDTO).getBloc, arguments.getRoomViewModel,
                arguments.getParticipantViewModel));

      case privateRoomRoute:

        return MaterialPageRoute(
            builder: (_) => ParticipantPage((arguments as ParticipantDTO).getBloc,
                arguments.getParticipantViewModel));

      default:
        return  _unknownRoute();
    }
  }

  static Route<dynamic> _unknownRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Rota não encontrada"),
        ),
        body: Center(
          child: Text("tela não encontrada"),
        ),
      );
    });
  }
}
