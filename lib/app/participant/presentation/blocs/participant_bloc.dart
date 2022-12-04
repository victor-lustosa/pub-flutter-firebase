import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../participant/domain/use-cases/send_private_message.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  final ISendPrivateMessage sendPrivateMessage;

  ParticipantBloc({required this.sendPrivateMessage,
            //required this.initialRoom,
            //required this.sendPublicMessage,
            //required this.leaveRoom,
            //required this.sendPrivateMessage,
            //required this.receiveMessage
            }) : super(InitialState()) {
    on<SendPrivateMessageEvent>(_sendPrivateMessageEvent);
  }

  Future<void> _sendPrivateMessageEvent(SendPrivateMessageEvent event, emit) async{
    /*_socket.emit('private_message', {
      'idSender': this.roomViewModel.getUser.getIdUser,
      'idReceiver': this.participantViewModel.getParticipant.getIdUser,
      'message': event.message
    });
    emit(SendPrivateMessageState());*/
  }
}

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
abstract class ParticipantState {}

class InitialState extends ParticipantState{
  InitialState();
}


