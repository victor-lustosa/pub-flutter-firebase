import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../participant/domain/use-cases/send_private_message.dart';
import '../../room/infra/models/data/message_data.dart';
import '../../room/view-models/room_view_model.dart';

part '../events/participant_event.dart';
part '../states/participant_state.dart';

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
