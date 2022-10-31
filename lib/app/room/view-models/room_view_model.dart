import 'dart:async';
import 'package:flutter/material.dart';
import '../../room/blocs/room_bloc.dart';
import '../../user/infra/models/user_model.dart';
import '../blocs/bloc_events.dart';
import '../infra/models/data/message_data.dart';
import '../infra/models/data/public_room_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../infra/models/room_model.dart';

abstract class IRoomViewModel {}

class RoomViewModel extends ChangeNotifier implements IRoomViewModel {
  RoomViewModel({required this.bloc}) {
    room = RoomModel.empty();
    mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });
  }
  late ScrollController scrollViewController;
  final RoomBloc bloc;
  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  List<dynamic> participants = [];
  List<dynamic> messages = [];
  List<RoomModel> rooms = [];
  late RoomModel room;
  late UserModel user;
  bool isParticipantExist = false;
  int lineNumbers = 1;
  double offset = 0.0;
  late StreamSubscription mSub;
  late TabController tabController;
  void delayForForms(BuildContext context) async {
    await Future.delayed(const Duration(minutes: 30));
    openURL(context);
  }
  addMessages(dynamic data) {
    messages.add(data);
  }

  scroll() {
    Timer(Duration(microseconds: 50), () {
      this.scrollViewController.jumpTo(this.scrollViewController.position.maxScrollExtent);
    });
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
    return isParticipantExist;
  }

  sendMessage(String type) {
    String textMessage = textController.text;
    if (type == "public") {
      if (textMessage.isNotEmpty) {
        var mes = MessageData(
            idRoom: this.room.id,
            createdAt: DateTime.now().toString(),
            roomName: this.room.name,
            idMessage: '',
            textMessage: textMessage.trimLeft().trimRight(),
            user: this.user,
            code: 0,
            type: BlocEventType.send_public_message);

        //messages.add(mes);

        bloc.add(SendMessageEvent(mes.toMap()));
        focusNode.requestFocus();
        textController.clear();
        focusNode.requestFocus();
      }
    } else {
      if (textMessage.isNotEmpty) {
        var mes = MessageData(
            idRoom: '',
            createdAt: DateTime.now().toString(),
            roomName: '',
            idMessage: '',
            textMessage: textMessage,
            user: this.participant,
            code: 0,
            type: BlocEventType.send_private_message);

        participant.messages.add(mes);

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
    if (data.user.nickname == user.nickname) {
      user = user.copyWith(
          idUser: data.user.idUser,
          latitude: user.latitude,
          longitude: user.longitude,
          nickname: user.nickname,
          genre: user.genre,
          age: user.age,
          messages: user.messages);
      room = room.copyWith(
          longitude: room.longitude,
          latitude: room.latitude,
          id: data.idRoom,
          name: room.name,
          distance: room.distance,
          isAcceptedLocation: room.isAcceptedLocation,
          participants: room.participants);
    } else {
      for (dynamic room in rooms) {
        if (room.getIdRoom == data.idRoom) {
          verifyParticipants(room, data);
          if (!isParticipantExist) {
            room.addParticipants(data.user);
          }
        }
        isParticipantExist = false;
      }
    }
    notifyListeners();
  }

  void removeParticipants(PublicRoomData data) {
    for (dynamic room in rooms) {
      if (room.getIdRoom == data.idRoom) {
        room.removeParticipants(data.user);
      }
    }
    notifyListeners();
  }

  late UserModel participant;

  void dispose() {
    textController.dispose();
    focusNode.dispose();
    mSub.cancel();
    bloc.close();
    super.dispose();
  }
}
