import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../room/blocs/room_bloc.dart';
import '../../room/domain/entities/room_entity.dart';
import '../../room/infra/models/room_model.dart';
import '../../user/infra/models/user_model.dart';
import 'package:geolocator/geolocator.dart';

import '../configs/app_routes.dart';
class LocationUtil {

  static verifyLocation(BuildContext context,
                       RoomBloc bloc,
                       StreamSubscription streamLocation,
                       RoomModel room,
                       UserModel user) {
    streamLocation = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
            accuracy: LocationAccuracy.best,
            timeLimit: Duration(minutes: 2)))
        .listen((position) {
      double distance = (Geolocator.distanceBetween(position.latitude,
          position.longitude, room.latitude, room.longitude) /
          1000);
      if (distance > 10.2) {
        bloc.add(LeaveRoomEvent(room:room, user:user));
        Navigator.pushNamed(context, AppRoutes.establishmentRoute,
            arguments: EstablishmentDTO(user));
        streamLocation.cancel();
      }
    });
  }

  static Future<UserModel> getPosition(UserModel _user) async {
    /* try{
      bool active = await Geolocator.isLocationServiceEnabled();
       if(active){
        Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.best);

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
    return _user;
    /* catch(e){
       error = e.toString();
     }*/
  }
 static double distanceBetweenUserAndEstablishments(
      UserModel user, double latitude, double longitude) {
    return (Geolocator.distanceBetween(
        user.latitude, user.longitude, latitude, longitude) /
        1000);
  }
  static List<RoomModel> calculateDistance(List<RoomEntity> rooms,UserModel user) {
    List<RoomModel> availableRoomsList = [];
    List<RoomModel> unavailableRoomsList = [];
    RoomModel _room = RoomModel.empty();
    for(RoomEntity room in rooms){
      double distance = distanceBetweenUserAndEstablishments(user, room.latitude, room.longitude);

      if (distance <= 0.5){
        RoomModel roomDto = _room.copyWith(
          id: room.id,
          name: room.name,
          latitude: room.latitude,
          longitude: room.longitude,
          distance: distance,
          participants: room.participants,
          isAcceptedLocation: true,
        );
        availableRoomsList.add(roomDto);
      }
      else{
        RoomModel roomDto = _room.copyWith(
          id: room.id,
          name: room.name,
          latitude: room.latitude,
          longitude: room.longitude,
          distance: distance,
          participants: room.participants,
          isAcceptedLocation: false,
        );
        unavailableRoomsList.add(roomDto);
      }
    }
    return List.from(availableRoomsList)..addAll(unavailableRoomsList);
  }
}