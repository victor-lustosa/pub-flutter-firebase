import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/user/external/datasources/user_shared_datasource.dart';
import 'app/Message_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/user/domain/entities/user_entity.dart';
import 'firebase_options.dart';
import 'dart:developer';
import 'dart:async';
import 'app/app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MessageBlocObserver();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  UserSharedDatasource<UserEntity> userSharedDatasource = UserSharedDatasource(shared: await SharedPreferences.getInstance());
  runZonedGuarded(
        () => runApp(AppWidget(userSharedDatasource: userSharedDatasource)),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );

}
