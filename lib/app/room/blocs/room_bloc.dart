import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../participant/view-models/participant_view_model.dart';
import '../domain/use-cases/initial_room.dart';
import '../domain/use-cases/leave_room.dart';
import '../domain/use-cases/receive_message.dart';
import '../domain/use-cases/send_private_message.dart';
import '../domain/use-cases/send_public_message.dart';
import 'bloc_events.dart';
import '../../room/infra/models/data/data.dart';
import '../../room/infra/models/data/message_data.dart';
import '../../room/infra/models/data/public_room_data.dart';
import '../../room/infra/models/data/rooms_data.dart';
import '../../room/view-models/room_view_model.dart';
import '../../shared/configs/app_routes.dart';

part '../events/room_event.dart';
part '../states/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {

  final IInitialRoom initialRoomUseCase;
  final ISendPublicMessage sendPublicMessageUseCase;
  final ISendPrivateMessage sendPrivateMessageUseCase;
  final IReceiveMessage receiveMessageUseCase;
  final ILeaveRoom leaveRoomUseCase;

  RoomBloc({required this.initialRoomUseCase,
  required this.sendPublicMessageUseCase,
  required this.leaveRoomUseCase,
  required this.sendPrivateMessageUseCase,
  required this.receiveMessageUseCase}) : super(InitialState()) {
    on<InitialRoomEvent>(_initialRoomEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<LeaveRoomEvent>(_leaveRoomEvent);
    on<SendPrivateMessageEvent>(_sendPrivateMessageEvent);
    on<DisconnectEvent>(_disconnectEvent);
    on<ReceiveMessageEvent>(_receiveMessageEvent);
    on<DontBuildEvent>(_dontBuildEvent);
  }
  Future<void> _initialRoomEvent(InitialRoomEvent event, emit) async{
    /*_socket.emit('enter_public_room', {
      'roomName': this.roomViewModel.getRoom.getRoomName,
      'idRoom': this.roomViewModel.getRoom.getIdRoom,
      'user': this.roomViewModel.getUser.toMap()
    });*/
  }
  Future<void> _sendMessageEvent(SendMessageEvent event, emit) async{
    /*_socket.emit('public_message', {'message': event.message});
    emit(SendMessageState());*/
  }
  Future<void> _leaveRoomEvent(LeaveRoomEvent event, emit) async{
    /*_socket.emit('leave_public_room', {
      'roomName': this.roomViewModel.getRoom.getRoomName,
      'idRoom': this.roomViewModel.getRoom.getIdRoom,
      'user': this.roomViewModel.getUser.toMap()
    });*/
  }
  Future<void> _sendPrivateMessageEvent(SendPrivateMessageEvent event, emit) async{
    /*_socket.emit('private_message', {
      'idSender': this.roomViewModel.getUser.getIdUser,
      'idReceiver': this.participantViewModel.getParticipant.getIdUser,
      'message': event.message
    });
    emit(SendPrivateMessageState());*/
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
  Future<void> _dontBuildEvent(DontBuildEvent event, emit) async{
   /* emit(DontBuildState());*/
  }

}
