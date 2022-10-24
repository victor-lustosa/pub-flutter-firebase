part of '../blocs/room_bloc.dart';

@immutable
abstract class RoomEvent {}

class InitialEvent extends RoomEvent{
  InitialEvent();
}
class InitialRoomEvent extends RoomEvent{
  InitialRoomEvent();
}
class DisconnectEvent extends RoomEvent{
  DisconnectEvent();
}
class LeaveRoomEvent extends RoomEvent{
  LeaveRoomEvent();
}
class DontBuildEvent extends RoomEvent{
  DontBuildEvent();
}
class GetRoomsEvent extends RoomEvent {
  GetRoomsEvent();
}
class SendMessageEvent extends RoomEvent{
  final Map<String,dynamic> message;
  SendMessageEvent(this.message);
}
class SendPrivateMessageEvent extends RoomEvent{
  final Map<String,dynamic> message;
  SendPrivateMessageEvent(this.message);
}

class SendingMessageEvent extends RoomEvent{
  SendingMessageEvent();
}

class ReceiveMessageEvent extends RoomEvent{
  final Map<String,dynamic> message;
  ReceiveMessageEvent(this.message);
}

class ErrorMessageEvent extends RoomEvent{
  ErrorMessageEvent();
}