
import '../../../user/infra/models/user_model.dart';
import '../../infra/models/room_model.dart';
import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class IRoomUseCases {
  Stream<List<RoomEntity>> getRooms();
  Future<void> enterRoom(RoomModel room, UserModel user);
  Future<void> receiveMessage();
  Future<void> sendMessage(message);
  Future<void> leaveRoom(RoomModel room, UserModel user);
}

class RoomUseCases implements IRoomUseCases {
  final IRoomRepository<RoomEntity> repository;

  RoomUseCases({required this.repository});

  @override
  Stream<List<RoomEntity>> getRooms() {
    return repository.get();
  }
  @override
  Future<void> enterRoom(RoomModel room, UserModel user) {
    return repository.add(room,user);
  }

  @override
  Future<void> leaveRoom(RoomModel room, UserModel user) {
    return repository.delete(room,user);
  }

  @override
  Future<void> receiveMessage() {
    // TODO: implement receiveMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(message) {
    return repository.sendMessage();
  }
}
