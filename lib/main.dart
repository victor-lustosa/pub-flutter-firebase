import 'package:flutter/material.dart';
import 'package:pub/app/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub/app/Message_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BlocOverrides.runZoned(
    () => runApp(const AppWidget()),
    blocObserver: MessageBlocObserver(),
  );
}
