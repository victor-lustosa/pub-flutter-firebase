import 'dart:async';
import 'package:flutter/material.dart';
import '../../room/domain/entities/message_entity.dart';
import '../../room/infra/models/room_model.dart';
import '../../shared/utils/location_util.dart';
import '../../user/infra/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/establishment_bloc.dart';

abstract class IEstablishmentViewModel {}

class EstablishmentViewModel extends ChangeNotifier
    implements IEstablishmentViewModel {
  EstablishmentViewModel({required this.bloc}) {
    room = RoomModel.empty();
    user = UserModel.empty();
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
    Timer(const Duration(microseconds: 50), () {
      scrollViewController.jumpTo(
        scrollViewController.position.maxScrollExtent,
      );
    });
  }

  openURL(BuildContext context) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possivel abrir a página'),
        ),
      );
    }

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

  void addParticipants(MessageEntity data) {
    if (data.user.nickname == user.nickname) {
      user = user.copyWith(
        idUser: data.user.idUser,
        latitude: user.latitude,
        longitude: user.longitude,
        nickname: user.nickname,
        genre: user.genre,
        age: user.age,
        messages: user.messages,
      );
      room = room.copyWith(
        longitude: room.longitude,
        latitude: room.latitude,
        id: data.roomId,
        name: room.name,
        distance: room.distance,
        isAcceptedLocation: room.isAcceptedLocation,
        participants: room.participants,
      );
    } else {
      for (dynamic room in rooms) {
        if (room.getIdRoom == data.roomId) {
          verifyParticipants(room, data);
          if (!isParticipantExist) {
            room.addParticipants(
              data.user,
            );
          }
        }
        isParticipantExist = false;
      }
    }
    notifyListeners();
  }

  void removeParticipants(MessageEntity data) {
    for (dynamic room in rooms) {
      if (room.getIdRoom == data.roomId) {
        room.removeParticipants(data.user);
      }
    }
    notifyListeners();
  }

  verifyParticipants(room, data) {
    for (dynamic participant in room.getParticipants) {
      if (data.getUser.getNickname == participant.getNickname) {
        isParticipantExist = true;
      }
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    mSub.cancel();
    bloc.close();
    super.dispose();
  }
}
