import 'package:pub/app/room/blocs/room_bloc.dart';
import 'package:pub/app/room/view-models/room_view_model.dart';

import '../../../../participant/view-models/participant_view_model.dart';

class RoomDTO {
  RoomBloc _bloc;
  RoomViewModel _roomViewModel;
  ParticipantViewModel _participantViewModel;
  get getBloc => _bloc;
  get getRoomViewModel => _roomViewModel;
  get getParticipantViewModel => _participantViewModel;

  RoomDTO({
    required RoomBloc bloc,
    required RoomViewModel roomViewModel,
    required ParticipantViewModel participantViewModel,
  })  : _bloc = bloc,
        _roomViewModel = roomViewModel,
        _participantViewModel = participantViewModel;
}
