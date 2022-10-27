import '../../../../room/view-models/room_view_model.dart';

class RoomDTO {
  RoomViewModel _roomViewModel;

  get getRoomViewModel => _roomViewModel;

  RoomDTO({required RoomViewModel roomViewModel})
      : _roomViewModel = roomViewModel;
}
