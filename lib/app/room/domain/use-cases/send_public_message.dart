import '../dtos/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class ISendPublicMessage {
  Future<void> call();
}

class SendPublicMessage implements ISendPublicMessage {
  final IRoomRepository repository;

  SendPublicMessage(this.repository);

  @override
  Future<void> call() {
    return repository.sendPublicMessage();
  }
}
