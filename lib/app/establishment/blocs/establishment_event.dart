part of 'establishment_bloc.dart';

@immutable
abstract class EstablishmentEvent {}

class InitialEvent extends EstablishmentEvent{
  InitialEvent();
}
class GetRoomsEvent extends EstablishmentEvent {
  GetRoomsEvent();
}
