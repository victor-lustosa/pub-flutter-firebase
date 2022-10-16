part of '../blocs/establishment_bloc.dart';

abstract class EstablishmentState {
  /* EstablishmentState(this.message, this.roomViewModel);
  final T message;
  final T roomViewModel;*/
}

class InitialState extends EstablishmentState {
  InitialState();
}

class LoadingEstablishmentsState extends EstablishmentState {
  LoadingEstablishmentsState();
}

class SuccessEstablishmentsState extends EstablishmentState {
  final List<EstablishmentEntity> entities;
  SuccessEstablishmentsState(this.entities);
}
