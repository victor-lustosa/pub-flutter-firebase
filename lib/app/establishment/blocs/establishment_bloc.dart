import 'dart:async';

import 'package:flutter/material.dart';
import '../../room/infra/models/message_model.dart';
import '../../room/domain/entities/room_entity.dart';
import 'package:bloc/bloc.dart';
import '../domain/use-cases/establishment_use_cases.dart';
import '../view-models/establishment_view_model.dart';

part 'establishment_event.dart';

part 'establishment_state.dart';

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
