import '../../../../room/blocs/room_bloc.dart';
import '../../../../room/view-models/room_view_model.dart';

class RoomDTO {
  RoomBloc _bloc;
  RoomViewModel _roomViewModel;

  get getBloc => _bloc;
  get getRoomViewModel => _roomViewModel;

  RoomDTO({
    required RoomBloc bloc,
    required RoomViewModel roomViewModel
  })  : _bloc = bloc,
        _roomViewModel = roomViewModel;
}
