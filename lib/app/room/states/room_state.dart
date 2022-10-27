part of '../blocs/room_bloc.dart';

abstract class RoomState {}
class InitialState extends RoomState{
  InitialState();
}
class EnterRoomState extends RoomState{
  EnterRoomState();
}

class SuccessRoomsState extends RoomState {
  final List<RoomEntity> entities;
  SuccessRoomsState(this.entities);
}
class EnterPublicRoomMessageState extends  RoomState{
  EnterPublicRoomMessageState({required PublicRoomData message, required RoomViewModel roomViewModel}){
    roomViewModel.addParticipants(message);
    if(message.user.nickname != roomViewModel.user.nickname)
      roomViewModel.addMessages(message);
  }
}
class LeavePublicRoomMessageState extends RoomState{
  LeavePublicRoomMessageState({required PublicRoomData message, required RoomViewModel roomViewModel}){
    roomViewModel.removeParticipants(message);
    if(message.user.nickname != roomViewModel.user.nickname)
      roomViewModel.addMessages(message);
  }
}
class ReceivePublicMessageState extends RoomState {
  ReceivePublicMessageState({required MessageData message, required RoomViewModel roomViewModel}){
    roomViewModel.addMessages(message);
  }
}
class ReceivePrivateMessageState extends RoomState {
  ReceivePrivateMessageState({required MessageData message, required RoomViewModel roomViewModel}){
    roomViewModel.addMessages(message);
  }
}

class TypingMessageState extends RoomState{
  TypingMessageState();
}

class StoppedTypingMessageState extends RoomState{
  StoppedTypingMessageState();
}

class SendMessageState extends RoomState{
  SendMessageState();
}
class SendPrivateMessageState extends RoomState{
  SendPrivateMessageState();
}

class SendingMessageState extends RoomState{
  SendingMessageState();
}
class DisconnectState extends RoomState{
  DisconnectState();
}

class EditMessageState extends RoomState{
  EditMessageState();
}

class DeleteMessageState extends RoomState{
  DeleteMessageState();
}

