import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pub/app/user/blocs/location_permission_enum.dart';
import '../../user/domain/entities/user_entity.dart';
import '../../user/domain/use-cases/user_use_cases.dart';

part '../events/user_event.dart';
part '../states/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(InitialState()) {
    on<GetUserEvent>(_get);
    on<SaveUserEvent>(_save);
    on<CheckUserLocationEvent>(_checkAccessToLocation);
  }

  Future<void> _get(_, emit) async{
    final user = await userUseCases.get();
    emit(FetchedUserState(user));
  }

  Future<void> _save(SaveUserEvent event, emit) async{
    userUseCases.add(event.entity);
    emit(UserSavedState());
  }

  Future<void> _checkAccessToLocation(_, emit) async{
    LocationPermissionEnum location =  await userUseCases.checkAccessToLocation();
    location.name;
    emit(UserSavedState());
  }

}
