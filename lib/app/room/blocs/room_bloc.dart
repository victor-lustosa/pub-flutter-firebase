import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../user/infra/models/user_model.dart';
import '../domain/entities/room_entity.dart';
import '../domain/use-cases/room_use_cases.dart';
import '../../room/infra/models/data/message_data.dart';
import '../../room/infra/models/data/public_room_data.dart';
import '../../room/view-models/room_view_model.dart';
import '../infra/models/room_model.dart';



part '../events/room_event.dart';
part '../states/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final IRoomUseCases roomUseCases;

  RoomBloc({required this.roomUseCases,
            }) : super(InitialState()) {
    on<GetRoomsEvent>(_getRooms);
    on<EnterRoomEvent>(_enterRoomEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<LeaveRoomEvent>(_leaveRoomEvent);
    on<DisconnectEvent>(_disconnectEvent);
    on<ReceiveMessageEvent>(_receiveMessageEvent);
  }
  Future<void> _getRooms(_, emit) async {
    await emit.onEach<List<RoomEntity>>(roomUseCases.getRooms(),
        onData: (rooms) {
          emit(SuccessRoomsState(rooms));
        });
  }
  Future<void> _enterRoomEvent(EnterRoomEvent event, emit) async{
    roomUseCases.enterRoom(event.room, event.user);
    emit(EnterRoomState());
  }
  Future<void> _sendMessageEvent(SendMessageEvent event, emit) async{
    /*_socket.emit('public_message', {'message': event.message});
    emit(SendMessageState());*/
  }
  Future<void> _leaveRoomEvent(LeaveRoomEvent event, emit) async{
    roomUseCases.leaveRoom(event.room, event.user);
    emit(LeaveRoomState());
  }

  Future<void> _receiveMessageEvent(ReceiveMessageEvent event, emit) async{
   /* Data data = Data.fromMap(event.message);

    switch (data.type) {
      case BlocEventType.update_rooms:
        return emit(SuccessRoomsState(
            message: RoomsData.fromMap(event.message),
            roomViewModel: roomViewModel));
      case BlocEventType.enter_public_room:
        return emit(EnterPublicRoomMessageState(
            message: PublicRoomData.fromMap(event.message),
            roomViewModel: roomViewModel));
      case BlocEventType.leave_public_room:
        return emit(LeavePublicRoomMessageState(
            message: PublicRoomData.fromMap(event.message),
            roomViewModel: roomViewModel));
      case BlocEventType.receive_public_message:
        return emit(ReceivePublicMessageState(
            message: MessageData.fromMap(event.message),
            roomViewModel: roomViewModel));
      case BlocEventType.receive_private_message:
        return emit(ReceivePrivateMessageState(
            message: MessageData.fromMap(event.message),
            participantViewModel: participantViewModel));
      default:
        break;
    }*/
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


