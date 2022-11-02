
import 'package:pub/app/room/domain/entities/message_entity.dart';
import 'package:pub/app/user/infra/adapters/user_adapter.dart';

import '../../../user/infra/models/user_model.dart';
import '../../blocs/bloc_events.dart';

class MessageModel extends MessageEntity{

  MessageModel({
    required String id,
    required String roomId,
    required String roomName,
    required UserModel user,
    required BlocEventType type,
    required String createdAt,
    required String textMessage
  }) :  super(id: id,
              type: type,
              textMessage: textMessage,
              createdAt: createdAt,
              user: user,
              roomId: roomId,
              roomName: roomName);


  factory MessageModel.empty() => MessageModel(
    id: '',
    roomId: '',
    roomName: '',
    user: UserModel.empty(),
    type: BlocEventType.useless,
    createdAt: '',
    textMessage: '',
  );

  MessageModel copyWith({
     String? id,
     String? roomId,
     String? roomName,
     UserModel? user,
     BlocEventType? type,
     String? createdAt,
     String? textMessage
  }) {
    return MessageModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      user: user ?? this.user,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      textMessage: textMessage ?? this.textMessage,
    );
  }
}


