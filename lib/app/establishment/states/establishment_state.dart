part of '../blocs/establishment_bloc.dart';

abstract class EstablishmentState <T> {
  EstablishmentState();
  /* EstablishmentState(this.message, this.roomViewModel);
  final T message;
  final T roomViewModel;*/
}
class InitialState extends EstablishmentState{
  InitialState() : super();
}

class LoadingRoomsState extends EstablishmentState{
  LoadingRoomsState() : super();
}
class SuccessRoomsState extends EstablishmentState{
  SuccessRoomsState() : super(){
   /* roomViewModel.fetchedRooms(message);*/
  }
}


