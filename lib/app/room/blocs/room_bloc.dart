import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pub/app/room/domain/entities/message_entity.dart';
import 'package:pub/app/room/infra/adapters/message_adapter.dart';
import '../../user/infra/models/user_model.dart';
import '../domain/entities/room_entity.dart';
import '../domain/use-cases/room_use_cases.dart';
import '../infra/models/message_model.dart';
import '../infra/models/room_model.dart';


part '../events/room_event.dart';
part '../states/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final IRoomUseCases roomUseCases;

  RoomBloc({required this.roomUseCases}) : super(InitialState()) {
    on<GetMessagesEvent>(_getRooms);
    on<EnterRoomEvent>(_enterRoomEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<LeaveRoomEvent>(_leaveRoomEvent);
    on<DisconnectEvent>(_disconnectEvent);
    on<ReceiveMessageEvent>(_receiveMessageEvent);
  }
  Future<void> _getRooms(_, emit) async {
    await emit.onEach<List<RoomEntity>>(roomUseCases.getRooms(),
        onData: (rooms) {
          emit(SuccessfullyFetchedRoomsState(rooms: rooms));
        });
  }
  Future<void> _enterRoomEvent(EnterRoomEvent event, emit) async{
    roomUseCases.enterRoom(event.room, event.user);
    emit(EnterRoomState());
  }
  Future<void> _sendMessageEvent(SendMessageEvent event, emit) async{
    roomUseCases.sendMessage(event.room, event.message);
    emit(SendMessageState());
  }
  Future<void> _leaveRoomEvent(LeaveRoomEvent event, emit) async{
    roomUseCases.leaveRoom(event.room, event.user);
    emit(LeaveRoomState());
  }

  Future<void> _receiveMessageEvent(ReceiveMessageEvent event, emit) async{

  }
  Future<void> _disconnectEvent(DisconnectEvent event, emit) async{
   /* _socket.emit('disconnect_user', {
      'roomName': this.roomViewModel.getRoom.getRoomName,
      'idRoom': this.roomViewModel.getRoom.getIdRoom,
      'userNickName': this.roomViewModel.getUser.getNickname
    });
    _socket.disconnect();*/
  }
}


