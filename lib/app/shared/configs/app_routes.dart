import 'package:flutter/material.dart';
import '../../establishment/presentation/views/establishment_view.dart';
import '../../home/views/home_view.dart';
import '../../room/presentation/views/room_view.dart';
import '../../user/presentation/views/user_register_view.dart';

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
    //final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case initialRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case establishmentRoute:
        return MaterialPageRoute(builder: (_) => const EstablishmentView());

      case userRegisterRoute:
        return MaterialPageRoute(builder: (_) => const UserRegisterView());

      // case ENTERPRISE_REGISTER_ROUTE:
      //   return MaterialPageRoute(builder: (_) =>  EnterpriseRegisterPage());

      case editUserRoute:
        return MaterialPageRoute(builder: (_) => const UserRegisterView());

      case publicRoomRoute:
        return MaterialPageRoute(builder: (_) => const RoomView());

      /* case privateRoomRoute:
        return MaterialPageRoute(builder: (_) => ParticipantPage(user: (arguments as ParticipantDTO).getUser));
      */
      default:
        return _unknownRoute();
    }
  }

  static Route<dynamic> _unknownRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rota não encontrada"),
          ),
          body: const Center(
            child: Text("tela não encontrada"),
          ),
        );
      },
    );
  }
}
