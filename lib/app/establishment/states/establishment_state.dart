part of '../blocs/establishment_bloc.dart';

abstract class EstablishmentState {}
class InitialState extends EstablishmentState{
  InitialState();
}

class SuccessfullyFetchedRoomsState extends EstablishmentState {
  final List<RoomEntity> entities;
  SuccessfullyFetchedRoomsState(this.entities);
}
