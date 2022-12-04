import 'dart:async';

import 'package:flutter/cupertino.dart';
import '../../room/presentation/blocs/room_bloc.dart';
import '../../room/domain/entities/room_entity.dart';
import '../../room/infra/models/room_model.dart';
import '../../user/infra/models/user_model.dart';
import 'package:geolocator/geolocator.dart';

import '../configs/app_routes.dart';

class LocationUtil {
  static Function verifyLocation = (
      BuildContext context, RoomBloc bloc,
      StreamSubscription streamLocation,
      RoomModel room, UserModel user) {
    streamLocation = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        timeLimit: Duration(minutes: 2),
      ),
    ).listen(
      (position) {
        double distance = (Geolocator.distanceBetween(position.latitude,
                position.longitude, room.latitude, room.longitude) /
            1000);
        if (distance > 10.2) {
          bloc.add(
            LeaveRoomEvent(
              room: room,
              user: user,
            ),
          );
          Navigator.pushNamed(
            context,
            AppRoutes.establishmentRoute,
          );
          streamLocation.cancel();
        }
      },
    );
  };

  static Function getPosition = (UserModel user) async {
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
    user = user.copyWith(
      latitude: -10.185408103868545,
      longitude: -48.32987275767158,
    );
    return user;
    /* catch(e){
       error = e.toString();
     }*/
  };

  static Function distanceBetweenUserAndEstablishments = (UserModel user, double latitude, double longitude) {
    return (Geolocator.distanceBetween(
            user.latitude, user.longitude, latitude, longitude) /
        1000);
  };

  static Function  calculateDistance = (List<RoomEntity> rooms, UserModel user) {
    List<RoomModel> availableRoomsList = [];
    List<RoomModel> unavailableRoomsList = [];
    RoomModel room = RoomModel.empty();
    for (RoomEntity r in rooms) {
      double distance = distanceBetweenUserAndEstablishments(
        user,
        r.latitude,
        r.longitude,
      );
      if (distance <= 0.5) {
        RoomModel roomDto = room.copyWith(
          id: r.id,
          name: r.name,
          latitude: r.latitude,
          longitude: r.longitude,
          distance: distance,
          participants: r.participants,
          isAcceptedLocation: true,
        );
        availableRoomsList.add(roomDto);
      } else {
        RoomModel roomDto = room.copyWith(
          id: r.id,
          name: r.name,
          latitude: r.latitude,
          longitude: r.longitude,
          distance: distance,
          participants: r.participants,
          isAcceptedLocation: false,
        );
        unavailableRoomsList.add(roomDto);
      }
    }
    return List.from(availableRoomsList)..addAll(unavailableRoomsList);
  };
}
