import 'package:flutter/material.dart';
import './app/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './app/Message_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MessageBlocObserver();
  runApp(const AppWidget());
}
