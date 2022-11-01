import 'package:flutter/material.dart';
import 'room/room_module.dart';
import 'establishment/establishment_module.dart';
import 'user/domain/entities/user_entity.dart';
import 'user/external/datasources/user_shared_datasource.dart';
import 'shared/configs/app_routes.dart';
import 'shared/configs/no_glow_behavior.dart';
import 'splash/views/splash_page.dart';
import 'package:provider/provider.dart';
import 'user/user_module.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({Key? key, required this.userDatasource}) : super(key: key);
  final UserSharedDatasource<UserEntity> userDatasource;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...establishmentModule,
        ...roomModule,
        ...Instance.userFlow(userDatasource)
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
