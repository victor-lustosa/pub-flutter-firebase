part of '../blocs/room_bloc.dart';

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

class EnterPublicRoomMessageState extends  RoomState{
  EnterPublicRoomMessageState({required MessageModel message, required RoomViewModel roomViewModel}){
    if(message.user.nickname != roomViewModel.user.nickname)
      roomViewModel.addMessages(message);
  }
}
class LeavePublicRoomMessageState extends RoomState{
  LeavePublicRoomMessageState({required MessageModel message, required RoomViewModel roomViewModel}){
    if(message.user.nickname != roomViewModel.user.nickname)
      roomViewModel.addMessages(message);
  }
}
class ReceivePublicMessageState extends RoomState {
  ReceivePublicMessageState({required MessageModel message, required RoomViewModel roomViewModel}){
    roomViewModel.addMessages(message);
  }
}
class ReceivePrivateMessageState extends RoomState {
  ReceivePrivateMessageState({required MessageModel message, required RoomViewModel roomViewModel}){
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

