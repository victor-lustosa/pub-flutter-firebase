import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../user/domain/entities/user_entity.dart';
import '../../user/domain/use-cases/save_user.dart';

part '../events/user_event.dart';
part '../states/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ISaveUser saveUser;

  UserBloc({required this.saveUser}) : super(InitialState()) {
    on<SaveUserEvent>(_saveUser);
  }

  Future<void> _saveUser(SaveUserEvent event, emit) async{
    saveUser.add(event.entity);
    emit(SaveSuccessState());
  }
}
