part of '../blocs/user_bloc.dart';

@immutable
abstract class UserEvent {}

class SaveUserEvent extends UserEvent{
  final UserEntity entity;
  SaveUserEvent(this.entity);
}