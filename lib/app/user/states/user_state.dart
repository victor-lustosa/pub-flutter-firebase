part of '../blocs/user_bloc.dart';

abstract class UserState {}
class InitialState extends UserState{
  InitialState();
}

class UserSavedState extends UserState {
  UserSavedState();
}
class FetchedUserState extends UserState {
  UserEntity? user;
  FetchedUserState(this.user);
}
