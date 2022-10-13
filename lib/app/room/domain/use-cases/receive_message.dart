//import '../dtos/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class IReceiveMessage {
  Future<void> call();
}

class ReceiveMessage implements IReceiveMessage {
  final IRoomRepository repository;

  ReceiveMessage(this.repository);

  @override
  Future<void> call() {
    return repository.receiveMessage();
  }
}
