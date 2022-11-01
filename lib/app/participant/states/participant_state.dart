part of '../blocs/participant_bloc.dart';

abstract class ParticipantState {}

class InitialState extends ParticipantState{
  InitialState();
}

class ReceivePrivateMessageState extends ParticipantState {
  ReceivePrivateMessageState({required MessageModel message, required RoomViewModel roomViewModel}){
    roomViewModel.addMessages(message);
  }
}

class SendingMessageState extends ParticipantState{
  SendingMessageState();
}

class DisconnectState extends ParticipantState{
  DisconnectState();
}


