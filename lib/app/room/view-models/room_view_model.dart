import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pub/app/participant/models/participant.dart';
import 'package:pub/app/user/infra/models/user_model.dart';

import '../../room/blocs/room_bloc.dart';
import '../blocs/bloc_events.dart';
import '../models/data/message_data.dart';
import '../models/data/public_room_data.dart';
import '../models/room.dart';

abstract class IRoomViewModel {

}

class RoomViewModel extends ChangeNotifier implements IRoomViewModel {
  RoomViewModel({required UserModel user, required Room room})
      : _user = user,
        _room = room {
  }

  late StreamSubscription subscription;


  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  // late bool boolAdd;
  String error = '';
  List<dynamic> _rooms = [];
  Room _room;
  UserModel _user;
  bool isParticipantExist = false;
  bool isUserExist = false;
  int lineNumbers = 1;

  // bool isVisibled = false;

  sendMessage(RoomBloc bloc) {
    String textMessage = textController.text;

    if (textMessage.isNotEmpty) {
      var mes = MessageData(
          idRoom: this.getRoom.getIdRoom,
          createdAt: DateTime.now().toString(),
          roomName: this.getRoom.getRoomName,
          idMessage: '',
          textMessage: textMessage.trimLeft().trimRight(),
          user: this.getUser,
          code: 0,
          type: BlocEventType.send_public_message);

      _room.getMessages.add(mes);

      bloc.add(SendMessageEvent(mes.toMap()));
      focusNode.requestFocus();
      textController.clear();
      focusNode.requestFocus();
    }
  }

  verifyParticipants(room, data) {
    for (dynamic participant in room.getParticipants) {
      if (data.getUser.getNickname == participant.getNickname) {
        isParticipantExist = true;
      }
    }
  }


  void addParticipants(PublicRoomData data) {
    if (data.getUser.getNickname == getUser.getNickname) {
      getUser.setIdUser(data.getUser.getIdUser);
      getRoom.setIdRoom(data.getIdRoom);
    } else {
      for (dynamic room in _rooms) {
        if (room.getIdRoom == data.getIdRoom) {
          verifyParticipants(room, data);
          if (!isParticipantExist) {
            room.addParticipants(
                Participant.convertUserToParticipant(data.getUser));
          }
        }
        isParticipantExist = false;
      }
    }
    notifyListeners();
  }
  verifyLocation(BuildContext context, RoomBloc bloc) {
    subscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
            accuracy: LocationAccuracy.best,
            timeLimit: Duration(minutes: 2)))
        .listen((position) {
      /*  double distance = (Geolocator.distanceBetween(position.latitude,
              position.longitude, getRoom.getLatitude, getRoom.getLongitude) /
          1000);
      if (distance > 10.2) {
        bloc.add(LeaveRoomEvent());
        Navigator.pushNamed(context, AppRoutes.establishmentRoute,
            arguments: EstablishmentDTO(getUser));
        subscription.cancel();
      }*/
    });
  }
  void removeParticipants(PublicRoomData data) {
    for (dynamic room in _rooms) {
      if (room.getIdRoom == data.getIdRoom) {
        room.removeParticipants(
            Participant.convertUserToParticipant(data.getUser));
      }
    }
    notifyListeners();
  }

  addMessages(message) {
    // if(boolAdd == true){
    // boolAdd = false;
    getRoom.addMessages(message);
  }

  get getUser => _user;
  get getRoom => _room;
  get getRooms => _rooms;

  setRoom(Room room) => _room = room;
  setUser(UserModel user) => _user = user;

  void dispose() {
    subscription.cancel();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
