
import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class IRoomUseCases {
  Stream<List<RoomEntity>> getRooms();
  Future<void> enterRoom(room, user);
  Future<void> receiveMessage(room, message);
  Future<void> sendMessage(room, message);
  Future<void> leaveRoom(room, user);
}

class RoomUseCases implements IRoomUseCases {
  final IRoomRepository<RoomEntity> repository;

  RoomUseCases({required this.repository});

  @override
  Stream<List<RoomEntity>> getRooms() {
    return repository.get();
  }

  @override
  Future<void> enterRoom(room, user) {
    return repository.add(room,user);
  }

  @override
  Future<void> leaveRoom(room, user) {
    return repository.delete(room,user);
  }

  @override
  Future<void> receiveMessage(room, message) {
    return repository.receiveMessage(room, message);
  }

  @override
  Future<void> sendMessage(room, message) {
    return repository.sendMessage(room, message);
  }
}
