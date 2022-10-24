import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../room/blocs/room_bloc.dart';
import '../../user/infra/models/user_model.dart';
import '../blocs/bloc_events.dart';
import '../domain/entities/room_entity.dart';
import '../infra/models/data/message_data.dart';
import '../infra/models/data/public_room_data.dart';
import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';
import '../infra/models/room_model.dart';

abstract class IRoomViewModel {}

class RoomViewModel extends ChangeNotifier implements IRoomViewModel {
  late StreamSubscription streamLocation;
  RoomViewModel({required UserModel user}) : _user = user {
    getPosition();
  }

  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  List<dynamic> participants = [];
  List<RoomEntity> _rooms = [];
  late RoomEntity _room;
  UserModel _user;
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

  void getPosition() async {
    /* try{
      bool active = await Geolocator.isLocationServiceEnabled();
       if(active){
        Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.best);

        developer.log('log latitude: ${position.latitude.toString()}');
        developer.log('log longitude: ${position.longitude.toString()}');

        _user = _user.copyWith(
          age: _user.age,
          nickname: _user.nickname,
          genre: _user.genre,
          latitude:position.latitude,
          longitude:position.longitude
        );
     _user = _user .copyWith(
         latitude:-10.182642569502747,
         longitude:-48.36052358794835
     );
       }
     }*/
     _user = _user.copyWith(
         latitude:-10.185408103868545,
         longitude:-48.32987275767158
     );
    /* catch(e){
       error = e.toString();
     }*/
  }

  double distanceBetweenUserAndEstablishments(
      UserModel user, double latitude, double longitude) {
    return (Geolocator.distanceBetween(
        user.latitude, user.longitude, latitude, longitude) /
        1000);
  }

  bool verifyNameUser(RoomModel room) {
    /* for (dynamic participant in room.getParticipants) {
        if (getUser.getNickname == participant.getNickname) {
          isUserExist = true;
        }
      }*/
    return isUserExist;
  }

  List<RoomModel> calculateDistance(List<RoomModel> rooms) {
    List<RoomModel> roomsList = [];
    for(RoomModel room in rooms){
      double result = distanceBetweenUserAndEstablishments(
          getUser, room.latitude, room.longitude);

      if (result <= 0.5){
        room = room.copyWith(
            isAcceptedLocation: true,
        );
        roomsList.add(room);
      }
      else{
        room = room.copyWith(
            isAcceptedLocation: false
        );
        roomsList.add(room);
      }

    }
    return roomsList;
  }

  sendMessage(RoomBloc bloc) {
    String textMessage = textController.text;

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

  verifyLocation(BuildContext context, RoomBloc bloc) {
    streamLocation = Geolocator.getPositionStream(
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
  setRooms(List<RoomEntity> rooms) => _rooms = rooms;
  setRoom(RoomEntity room) => _room = room;
  setUser(UserModel user) => _user = user;

  void dispose() {
    streamLocation.cancel();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
