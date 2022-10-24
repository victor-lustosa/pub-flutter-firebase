part of '../blocs/user_bloc.dart';

abstract class UserState {}
class InitialState extends UserState{
  InitialState();
}

class SaveSuccessState extends UserState {
  SaveSuccessState();
}
