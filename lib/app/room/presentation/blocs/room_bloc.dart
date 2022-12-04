import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../room/domain/entities/message_entity.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/infra/models/user_model.dart';

import '../../domain/use-cases/room_use_cases.dart';
import '../../infra/models/message_model.dart';
import '../../infra/models/room_model.dart';


class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final IRoomUseCases roomUseCases;

  RoomBloc({required this.roomUseCases}) : super(InitialState()) {
    on<GetMessagesEvent>(_getMessages);
    on<GetParticipantsEvent>(_getParticipants);
    on<EnterRoomEvent>(_enterRoomEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<LeaveRoomEvent>(_leaveRoomEvent);
    on<DisconnectEvent>(_disconnectEvent);
    on<ReceiveMessageEvent>(_receiveMessageEvent);
  }

  Future<void> _getMessages(event, emit) async {
    await emit.onEach<List<MessageEntity>>(
        roomUseCases.getMessages(event.room),
        onData: (messages) {
      emit(
        SuccessfullyFetchedMessagesState(messages: messages),
      );
    });
  }

  Future<void> _getParticipants(event, emit) async {
    await emit.onEach<List<UserEntity>>(
        roomUseCases.getParticipants(event.room),
        onData: (participants) {
      emit(
        SuccessfullyFetchedParticipantsState(participants: participants),
      );
    });
  }

  Future<void> _enterRoomEvent(EnterRoomEvent event, emit) async {
    roomUseCases.enterRoom(
      event.room,
      event.user,
    );

    /*await emit.onEach<List<RoomEntity>>(roomUseCases.getRooms(),
        onData: (rooms) {
          emit(
              emit(EnterRoomState()),
          );
        });*/
  }

  Future<void> _sendMessageEvent(SendMessageEvent event, emit) async {
    roomUseCases.sendMessage(
      event.room,
      event.message,
    );
    emit(SendMessageState());
  }

  Future<void> _leaveRoomEvent(LeaveRoomEvent event, emit) async {
    roomUseCases.leaveRoom(
      event.room,
      event.user,
    );
    emit(LeaveRoomState());
  }

  Future<void> _receiveMessageEvent(ReceiveMessageEvent event, emit) async {}

  Future<void> _disconnectEvent(DisconnectEvent event, emit) async {
    /* _socket.emit('disconnect_user', {
      'roomName': this.roomViewModel.getRoom.getRoomName,
      'idRoom': this.roomViewModel.getRoom.getIdRoom,
      'userNickName': this.roomViewModel.getUser.getNickname
    });
    _socket.disconnect();*/
  }
}

@immutable
abstract class RoomEvent {}

class InitialEvent extends RoomEvent{
  InitialEvent();
}
class EnterRoomEvent extends RoomEvent{
  final RoomModel room;
  final UserModel user;
  EnterRoomEvent({required this.user, required this.room});
}
class LeaveRoomEvent extends RoomEvent{
  final RoomModel room;
  final UserModel user;
  LeaveRoomEvent({required this.user, required this.room});
}

class SendMessageEvent extends RoomEvent{
  final RoomModel room;
  final MessageModel message;
  SendMessageEvent({required this.room, required this.message});
}

class GetMessagesEvent extends RoomEvent{
  final RoomModel room;
  GetMessagesEvent({required this.room});
}

class GetParticipantsEvent extends RoomEvent{
  final RoomModel room;
  GetParticipantsEvent({required this.room});
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

class SuccessfullyFetchedMessagesState extends RoomState {
  final List<MessageEntity> messages;
  SuccessfullyFetchedMessagesState({required this.messages});
}

class SuccessfullyFetchedParticipantsState extends RoomState {
  final List<UserEntity> participants;
  SuccessfullyFetchedParticipantsState({required this.participants});
}
class SendMessageState extends RoomState{
  SendMessageState();
}


