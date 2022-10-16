import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class ISendPrivateMessage {
  Future<void> call();
}

class SendPrivateMessage implements ISendPrivateMessage {
  final IRoomRepository repository;

  SendPrivateMessage(this.repository);

  @override
  Future<void> call() {
    return repository.sendPrivateMessage();
  }
}
