import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pub/app/establishment/domain/use-cases/get_establishments.dart';

part '../events/establishment_event.dart';
part '../states/establishment_state.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {

  final IGetEstablishments getEstablishmentsUseCase;


  EstablishmentBloc({required this.getEstablishmentsUseCase}) : super(InitialState()) {
    on<GetEstablishmentsEvent>(_getEstablishments);

  }

  Future<void> _getEstablishments(GetEstablishmentsEvent event, emit) async{
   /* _socket.emit('initial_rooms', {
      'latitude': roomViewModel.getUser.getLatitude,
      'longitude': roomViewModel.getUser.getLongitude
    });*/
  }

}
