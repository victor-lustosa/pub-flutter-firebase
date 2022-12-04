import '../../../user/infra/models/user_model.dart';
import '../../presentation/blocs/bloc_events.dart';

class MessageEntity {
  final String id;
  final String roomId;
  final String roomName;
  final UserModel user;
  final BlocEventType type;
  final String createdAt;
  final String textMessage;

  MessageEntity({
    required this.id,
    required this.roomId,
    required this.roomName,
    required this.type,
    required this.createdAt,
    required this.textMessage,
    required this.user,
  });
}