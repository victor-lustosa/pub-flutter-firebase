import '../../../participant/domain/repositories/participant_repository.dart';
import '../../../room/infra/models/data/data.dart';

abstract class ISendPrivateMessage {
  Future<void> call(MessageData message);
}

class SendPrivateMessage implements ISendPrivateMessage {
  final IParticipantRepository repository;

  SendPrivateMessage(this.repository);

  @override
  Future<void> call(MessageData message) {
    return repository.add(message);
  }
}
