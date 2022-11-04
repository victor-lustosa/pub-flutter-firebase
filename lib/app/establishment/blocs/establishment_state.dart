part of 'establishment_bloc.dart';

abstract class EstablishmentState {}
class InitialState extends EstablishmentState{
  InitialState();
}

class SuccessfullyFetchedRoomsState extends EstablishmentState {
  final List<RoomEntity> entities;
  SuccessfullyFetchedRoomsState({required this.entities});
}

class EnterPublicRoomMessageState extends  EstablishmentState{
  EnterPublicRoomMessageState({required MessageModel message, required EstablishmentViewModel establishmentViewModel}){
    establishmentViewModel.addParticipants(message);
  }
}
class LeavePublicRoomMessageState extends EstablishmentState{
  LeavePublicRoomMessageState({required MessageModel message, required EstablishmentViewModel establishmentViewModel}){
    establishmentViewModel.removeParticipants(message);
  }
}