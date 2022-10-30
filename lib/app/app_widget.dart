import 'package:flutter/material.dart';
import 'package:pub/app/room/external/room_firestore_datasource.dart';

import 'package:pub/app/room/blocs/room_bloc.dart';
import 'package:pub/app/room/domain/use-cases/room_use_cases.dart';
import 'package:pub/app/room/infra/repositories/room_repository.dart';
import 'package:pub/app/room/view-models/room_view_model.dart';
import 'package:pub/app/user/blocs/user_bloc.dart';
import 'package:pub/app/user/domain/entities/user_entity.dart';
import 'package:pub/app/user/domain/use-cases/user_use_cases.dart';
import 'package:pub/app/user/external/datasources/user_shared_datasource.dart';
import 'package:pub/app/user/infra/repositories/user_repository.dart';
import 'shared/configs/app_routes.dart';
import 'shared/configs/no_glow_behavior.dart';
import 'splash/views/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppWidget extends StatelessWidget {

  const AppWidget({Key? key, required this.userSharedDatasource}) : super(key: key);
  final UserSharedDatasource<UserEntity> userSharedDatasource;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserBloc>(create: (context) => UserBloc(userUseCases:
                                                  UserUseCases(repository:
                                                     UserRepository(datasource: userSharedDatasource)))),
        Provider<RoomBloc>(create: (context) => RoomBloc(roomUseCases:
                                                    RoomUseCases(repository:
                                                        RoomRepository(datasource:
                                                           RoomFirestoreDatasource(firestore: FirebaseFirestore.instance))))),
        ChangeNotifierProvider<RoomViewModel>(create: (context) => RoomViewModel(bloc: context.read()))
      ],
      child: MaterialApp(
        builder: (context, Widget? child) {
          return ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          );
        },
        initialRoute: "/",
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Pub',
        home: SplashPage(),
      ),
    );
  }
}
