part of 'participant_bloc.dart';

@immutable
abstract class ParticipantEvent {}

class InitialEvent extends ParticipantEvent{
  InitialEvent();
}

class DisconnectEvent extends ParticipantEvent{
  DisconnectEvent();
}

class SendPrivateMessageEvent extends ParticipantEvent{
  final Map<String,dynamic> message;
  SendPrivateMessageEvent(this.message);
}

class ReceiveMessageEvent extends ParticipantEvent{
  final Map<String,dynamic> message;
  ReceiveMessageEvent(this.message);
}

class ErrorMessageEvent extends ParticipantEvent{
  ErrorMessageEvent();
}