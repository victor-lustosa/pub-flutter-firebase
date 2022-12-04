import 'dart:async';

import 'package:flutter/material.dart';
import '../../../room/infra/models/message_model.dart';
import '../../../room/domain/entities/room_entity.dart';
import 'package:bloc/bloc.dart';
import '../../domain/use-cases/establishment_use_cases.dart';
import '../view-models/establishment_view_model.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {
  final IEstablishmentUseCases roomUseCases;

  EstablishmentBloc({
    required this.roomUseCases,
  }) : super(InitialState()) {
    on<GetRoomsEvent>(_getRooms);
  }

  Future<void> _getRooms(_, emit) async {
    await emit.onEach<List<RoomEntity>>(
      roomUseCases.getRooms(),
      onData: (rooms) {
        emit(
          SuccessfullyFetchedRoomsState(entities: rooms),
        );
      },
    );
  }
}

@immutable
abstract class EstablishmentEvent {}

class InitialEvent extends EstablishmentEvent{
  InitialEvent();
}
class GetRoomsEvent extends EstablishmentEvent {
  GetRoomsEvent();
}
abstract class EstablishmentState {}

class InitialState extends EstablishmentState {
  InitialState();
}

class SuccessfullyFetchedRoomsState extends EstablishmentState {
  final List<RoomEntity> entities;

  SuccessfullyFetchedRoomsState({required this.entities});
}

class EnterPublicRoomMessageState extends EstablishmentState {
  EnterPublicRoomMessageState(
      {required MessageModel message,
        required EstablishmentViewModel establishmentViewModel}) {
    establishmentViewModel.addParticipants(message);
  }
}

class LeavePublicRoomMessageState extends EstablishmentState {
  LeavePublicRoomMessageState(
      {required MessageModel message,
        required EstablishmentViewModel establishmentViewModel}) {
    establishmentViewModel.removeParticipants(message);
  }
}