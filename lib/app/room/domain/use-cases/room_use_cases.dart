
import '../../../user/domain/entities/user_entity.dart';
import '../entities/message_entity.dart';
import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class IRoomUseCases {
  Stream<List<RoomEntity>> getRooms();
  Stream<List<MessageEntity>> getMessages(room);
  Stream<List<UserEntity>> getParticipants(room);
  Future<void> enterRoom(room, user);
  Future<void> sendMessage(room, message);
  Future<void> leaveRoom(room, user);
}

class RoomUseCases implements IRoomUseCases {
  final IRoomRepository<RoomEntity> repository;

  RoomUseCases({required this.repository});

  @override
  Stream<List<RoomEntity>> getRooms() {
    return repository.getRooms();
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
  Stream<List<MessageEntity>> getMessages(room) {
    return repository.getMessages(room);
  }

  @override
  Stream<List<UserEntity>> getParticipants(room) {
    return repository.getParticipants(room);
  }

  @override
  Future<void> sendMessage(room, message) {
    return repository.sendMessage(room, message);
  }
}
