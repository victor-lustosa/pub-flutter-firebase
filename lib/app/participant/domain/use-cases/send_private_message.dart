import 'package:pub/app/participant/domain/repositories/participant_repository.dart';
import 'package:pub/app/room/infra/models/data/message_data.dart';

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
