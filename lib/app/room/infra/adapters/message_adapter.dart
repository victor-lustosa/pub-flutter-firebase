import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../../blocs/bloc_events.dart';
import '../../domain/entities/message_entity.dart';
import '../models/message_model.dart';

class MessageAdapter {
  static MessageModel fromMap(dynamic map) {
    return MessageModel(
      id: map['id'],
      roomId: map['roomId'],
      roomName: map['roomName'],
      createdAt: map['createdAt'],
      textMessage: map['textMessage'],
      user: UserAdapter.fromMap(map['user']),
      type: BlocEventType.values.firstWhere(
        (element) => element.name.toString() == map['type'],
      ),
    );
  }

  static Map<String, dynamic> toMap(MessageEntity room) {
    return {
      'id': room.id,
      'roomId': room.roomId,
      'roomName': room.roomName,
      'createdAt': room.createdAt,
      'textMessage': room.textMessage,
      'user': UserAdapter.toMap(room.user),
      'type': room.type.name.toString()
    };
  }
}
