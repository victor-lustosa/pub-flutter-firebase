import 'package:flutter/material.dart';
import 'package:pub/app/user/view-models/user_view_model.dart';
import 'establishment/external/establishment_firestore_datasource.dart';
import 'establishment/blocs/establishment_bloc.dart';
import 'establishment/domain/use-cases/establishment_use_cases.dart';
import 'establishment/infra/repositories/establishment_repository.dart';
import 'establishment/view-models/establishment_view_model.dart';
import 'room/external/room_firestore_datasource.dart';
import 'room/blocs/room_bloc.dart';
import 'room/domain/use-cases/room_use_cases.dart';
import 'room/infra/repositories/room_repository.dart';
import 'room/view-models/room_view_model.dart';
import 'user/blocs/user_bloc.dart';
import 'user/domain/entities/user_entity.dart';
import 'user/domain/use-cases/user_use_cases.dart';
import 'user/external/datasources/user_shared_datasource.dart';
import 'user/infra/repositories/user_repository.dart';
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
        Provider<EstablishmentBloc>(create: (context) => EstablishmentBloc(roomUseCases:
                                                  EstablishmentUseCases(repository:
                                                      EstablishmentRepository(datasource:
                                                           EstablishmentFirestoreDatasource(firestore: FirebaseFirestore.instance))))),

        Provider<UserBloc>(create: (context) => UserBloc(userUseCases:
                                                  UserUseCases(repository:
                                                     UserRepository(datasource: userSharedDatasource)))),

        Provider<RoomBloc>(create: (context) => RoomBloc(roomUseCases:
                                                    RoomUseCases(repository:
                                                        RoomRepository(datasource:
                                                           RoomFirestoreDatasource(firestore: FirebaseFirestore.instance))))),

        ChangeNotifierProvider<EstablishmentViewModel>(create: (context) => EstablishmentViewModel(bloc: context.read())),
        ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel(bloc: context.read())),
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
