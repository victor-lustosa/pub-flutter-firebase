part of '../blocs/establishment_bloc.dart';

@immutable
abstract class EstablishmentEvent {}

class InitialEvent extends EstablishmentEvent{
  InitialEvent();
}
class GetEstablishmentsEvent extends EstablishmentEvent{
  GetEstablishmentsEvent();
}

class ErrorMessageEvent extends EstablishmentEvent{
  ErrorMessageEvent();
}