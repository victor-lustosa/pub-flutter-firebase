part of '../blocs/room_bloc.dart';

@immutable
abstract class RoomEvent {}

class InitialEvent extends RoomEvent{
  InitialEvent();
}
class GetRoomsEvent extends RoomEvent {
  GetRoomsEvent();
}
class EnterRoomEvent extends RoomEvent{
  final RoomModel room;
  final UserModel user;
  EnterRoomEvent({ required this.user, required this.room});
}
class LeaveRoomEvent extends RoomEvent{
  final RoomModel room;
  final UserModel user;
  LeaveRoomEvent({ required this.user, required this.room});
}

class SendMessageEvent extends RoomEvent{
  final dynamic message;
  SendMessageEvent(this.message);
}

class DisconnectEvent extends RoomEvent{
  DisconnectEvent();
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