import '../../../participant/domain/repositories/participant_repository.dart';
import '../../../room/infra/models/message_model.dart';

abstract class ISendPrivateMessage {
  Future<void> call(MessageModel message);
}

class SendPrivateMessage implements ISendPrivateMessage {
  final IParticipantRepository repository;

  SendPrivateMessage(this.repository);

  @override
  Future<void> call(MessageModel message) {
    return repository.add(message);
  }
}
