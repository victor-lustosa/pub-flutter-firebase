import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pub/app/establishment/domain/dtos/establishment_entity.dart';
import 'package:pub/app/user/models/user.dart';
import '../../core/configs/app_routes.dart';
import '../../room/blocs/room_bloc.dart';
import '../../establishment/models/dto/establishment_dto.dart';
import 'package:url_launcher/url_launcher.dart';
class EstablishmentViewModel {
  EstablishmentViewModel({required User user})
      : _user = user
         {
    getPosition();
  }

  late StreamSubscription subscription;
  final Uri _url = Uri.parse('https://flutter.dev');
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  // late bool boolAdd;
  String error = '';
  List<dynamic> _rooms = [];

  User _user;
  bool isParticipantExist = false;
  bool isUserExist = false;
  int lineNumbers = 1;

  get getUser => _user;

  get getRooms => _rooms;

  setUser(User user) => _user = user;

  // bool isVisibled = false;
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
    // try{
    //   bool active = await Geolocator.isLocationServiceEnabled();
    //   if(!active){
    //     Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.best);
    //     developer.log('log latitude: ${position.latitude.toString()}');
    //     getUser.setLatitude(position.latitude);
    //     developer.log('log longitude: ${position.longitude.toString()}');
    //     getUser.setLongitude(position.longitude);
    getUser.setLatitude(-10.182642569502747);
    getUser.setLongitude(-48.36052358794835);
    //   }
    // }catch(e){
    //   error = e.toString();
    // }
  }

  double distanceBetweenUserAndEstablishments(
      User user, double latitude, double longitude) {
    return (Geolocator.distanceBetween(
            user.getLatitude, user.getLongitude, latitude, longitude) /
        1000);
  }

  fetchedRooms(message) {
  /*  _rooms = [];
    for (dynamic roomData in message.getRooms) {
      Room room = Room.fromMinimalMap(roomData);
      room.setDistance(distanceBetweenUserAndEstablishments(
          getUser, room.getLatitude, room.getLongitude));
      _rooms.add(room);
    }*/
  }
  bool verifyNameUser(EstablishmentEntity room) {
   /* for (dynamic participant in room.getParticipants) {
      if (getUser.getNickname == participant.getNickname) {
        isUserExist = true;
      }
    }*/
    return isUserExist;
  }

  bool isAcceptedLocation(room) {
    double result = distanceBetweenUserAndEstablishments(
        getUser, room.getLatitude, room.getLongitude);
    if (result <= 0.5)
      return true;
    else
      return false;
  }

  void dispose() {
    subscription.cancel();
    textController.dispose();
    focusNode.dispose();
  }
}
