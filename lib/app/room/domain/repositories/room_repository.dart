//import '../dtos/room_entity.dart';

abstract class IRoomRepository {
  Future<void> enterTheRoom();

  Future<void> sendPublicMessage();
  Future<void> sendPrivateMessage();
  Future<void> receiveMessage();
  Future<void> leaveRoom();
}
