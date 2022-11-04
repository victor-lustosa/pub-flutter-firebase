part of 'room_bloc.dart';

abstract class RoomState {}
class InitialState extends RoomState{
  InitialState();
}
class EnterRoomState extends RoomState{
  EnterRoomState();
}

class LeaveRoomState extends RoomState{
  LeaveRoomState();
}

class SuccessfullyFetchedRoomsState extends RoomState {
  final List<RoomEntity> rooms;
  SuccessfullyFetchedRoomsState({required this.rooms});
}

class SendMessageState extends RoomState{
  SendMessageState();
}


