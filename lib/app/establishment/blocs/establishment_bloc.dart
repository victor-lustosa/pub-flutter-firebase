import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pub/app/establishment/domain/use-cases/get_establishments.dart';

import '../domain/entities/establishment_entity.dart';

part '../events/establishment_event.dart';
part '../states/establishment_state.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {
  final IGetEstablishments getEstablishments;

  EstablishmentBloc({required this.getEstablishments}) : super(InitialState()) {
    on<GetEstablishmentsEvent>(_getEstablishments);
  }

  Future<void> _getEstablishments(event, emit) async {
    await emit.onEach<List<EstablishmentEntity>>(getEstablishments.call(),
        onData: (establishments) {
      emit(SuccessEstablishmentsState(establishments));
    });
    /* _socket.emit('initial_rooms', {
      'latitude': roomViewModel.getUser.getLatitude,
      'longitude': roomViewModel.getUser.getLongitude
    });*/
  }
}
