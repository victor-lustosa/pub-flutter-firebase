import 'dart:async';
import 'package:flutter/material.dart';
import '../../room/blocs/room_bloc.dart';
import '../../room/infra/models/data/data.dart';
import '../../room/infra/models/room_model.dart';
import '../../shared/components/location_util.dart';
import '../../user/infra/models/user_model.dart';

import 'package:url_launcher/url_launcher.dart';

import '../blocs/establishment_bloc.dart';


abstract class IEstablishmentViewModel {}

class EstablishmentViewModel extends ChangeNotifier implements IEstablishmentViewModel {
  EstablishmentViewModel({required this.bloc}) {
    room = RoomModel.empty();
    mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });
  }
  late ScrollController scrollViewController;
  final EstablishmentBloc bloc;
  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  List<RoomModel> rooms = [];
  List<dynamic> participants = [];
  late RoomModel room;
  late UserModel user;
  bool isParticipantExist = false;
  late StreamSubscription mSub;
  late TabController tabController;
  void delayForForms(BuildContext context) async {
    await Future.delayed(const Duration(minutes: 30));
    openURL(context);
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

  verifyParticipants(room, data) {
    for (dynamic participant in room.getParticipants) {
      if (data.getUser.getNickname == participant.getNickname) {
        isParticipantExist = true;
      }
    }
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
