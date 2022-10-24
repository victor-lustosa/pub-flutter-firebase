import 'dart:async';

import 'package:flutter/material.dart';

import '../../room/blocs/room_bloc.dart';

import '../../user/infra/models/user_model.dart';
import '../blocs/bloc_events.dart';
import '../domain/entities/room_entity.dart';
import '../infra/models/data/message_data.dart';
import '../infra/models/data/public_room_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../infra/models/room_model.dart';

abstract class IRoomViewModel {}

class RoomViewModel extends ChangeNotifier implements IRoomViewModel {

  RoomViewModel() {
    _room = RoomModel.empty();
  }

  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  List<dynamic> participants = [];
  List<RoomModel> _rooms = [];
  late RoomModel _room;
  late UserModel _user;
  bool isParticipantExist = false;
  bool isUserExist = false;
  int lineNumbers = 1;

  void delayForForms(BuildContext context) async {
    await Future.delayed(const Duration(minutes: 30));
    openURL(context);
  }

  openURL(BuildContext context) async {
    if (await canLaunchUrl(_url))
      await launchUrl(_url);
    else
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possivel abrir a página')));

    /// Não è possível abrir a URL
  }


  bool verifyNameUser(RoomModel room) {
    /* for (dynamic participant in room.getParticipants) {
        if (getUser.getNickname == participant.getNickname) {
          isUserExist = true;
        }
      }*/
    return isUserExist;
  }

  sendMessage(RoomBloc bloc, String type) {
    String textMessage = textController.text;
    if(type == "public"){
    if (textMessage.isNotEmpty) {
      var mes = MessageData(
          idRoom: this.getRoom.id,
          createdAt: DateTime.now().toString(),
          roomName: this.getRoom.name,
          idMessage: '',
          textMessage: textMessage.trimLeft().trimRight(),
          user: this.getUser,
          code: 0,
          type: BlocEventType.send_public_message);

      _room.messages.add(mes);

      bloc.add(SendMessageEvent(mes.toMap()));
      focusNode.requestFocus();
      textController.clear();
      focusNode.requestFocus();
    }
    } else{
      if (textMessage.isNotEmpty) {
        var mes = MessageData(
            idRoom: '',
            createdAt: DateTime.now().toString(),
            roomName: '',
            idMessage: '',
            textMessage: textMessage,
            user: this.getParticipant,
            code: 0,
            type: BlocEventType.send_private_message);

        _participant.messages.add(mes);

        bloc.add(SendPrivateMessageEvent(mes.toMap()));
        focusNode.requestFocus();
        textController.clear();
        focusNode.requestFocus();
      }
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
            room.addParticipants(data.getUser);
          }
        }
        isParticipantExist = false;
      }
    }
    notifyListeners();
  }



  void removeParticipants(PublicRoomData data) {
    for (dynamic room in _rooms) {
      if (room.getIdRoom == data.getIdRoom) {
        room.removeParticipants(data.getUser);
      }
    }
    notifyListeners();
  }

  addMessages(message) {
    // if(boolAdd == true){
    // boolAdd = false;
    getRoom.addMessages(message);
  }

  get getRoom => _room;
  get getRooms => _rooms;
  get getUser => _user;
  setRooms(List<RoomModel> rooms) => _rooms = rooms;
  setRoom(RoomModel room) => _room = room;
  setUser(UserModel user) => _user = user;

  late UserModel _participant;

  get getParticipant => _participant;

  setParticipant(UserModel participant) => _participant = participant;

  /*void addMessages(MessageData message) {
    getParticipant.addMessages(message);
  }*/

// reload(RoomBloc bloc) {
//   widget.bloc.add(LoadingRoomsEvent());
// }

  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
