import 'dart:async';
import 'package:flutter/material.dart';
import '../../room/blocs/room_bloc.dart';
import '../../shared/components/id_util.dart';
import '../../shared/components/location_util.dart';
import '../../user/infra/models/user_model.dart';
import '../blocs/bloc_events.dart';
import '../domain/entities/message_entity.dart';
import '../domain/entities/room_entity.dart';
import '../infra/models/message_model.dart';

import 'package:url_launcher/url_launcher.dart';
import '../infra/models/room_model.dart';

abstract class IRoomViewModel {}

class RoomViewModel extends ChangeNotifier implements IRoomViewModel {
  RoomViewModel({required this.bloc}) {
    room = RoomModel.empty();
  }
  late ScrollController scrollViewController;
  final RoomBloc bloc;
  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  List<UserModel> participants = [];
  List<MessageEntity> messages = [];
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
  fetchedMessagesList(List<RoomEntity> rooms){
    for(RoomEntity roomFetched in rooms){
      if(roomFetched.id == this.room.id){
        messages = roomFetched.messages;
      }
    }
  }
  getUser() async {
    user = await LocationUtil.getPosition(user);
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
      if (room.isAcceptedLocation) {
        /* for (dynamic participant in room.participants) {
        if (user.nickname == participant.nickname) {
          isParticipantExist = true;
        }
      }*/
        if (!isParticipantExist) {
          this.room = room;
        }
      }
    return isParticipantExist;
  }

  sendMessage() {
    String textMessage = textController.text;
      //messages.add(mes);
      //participant.messages.add(mes);
      if (textMessage.isNotEmpty) {

          MessageModel message = MessageModel(
            id: IdUtil.generateRandomString(),
            roomId: this.room.id,
            createdAt: DateTime.now().toString(),
            roomName: this.room.name,
            textMessage: textMessage.trimLeft().trimRight(),
            user: this.user,
            type: BlocEventType.conversation_message);

          bloc.add(SendMessageEvent(room: room, message: message));
          focusNode.requestFocus();
          textController.clear();
    }
  }

  void dispose() {
    textController.dispose();
    focusNode.dispose();
    mSub.cancel();
    bloc.close();
    super.dispose();
  }
}
