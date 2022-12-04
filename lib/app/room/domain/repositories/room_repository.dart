
import 'package:pub/app/room/domain/entities/message_entity.dart';

import '../../../user/domain/entities/user_entity.dart';

abstract class IRoomRepository <T>{
  Future<void> add(T,P);
  Future<void> sendMessage(T,P);
  Future<void> delete(T,P);
  Stream<List<UserEntity>> getParticipants(T);
  Stream<List<MessageEntity>> getMessages(T);
  Stream<List<T>> getRooms();
}
