
import '../../../core/infra/datasources/datasource.dart';
import '../../../user/infra/models/user_model.dart';
import '../models/message_model.dart';
import '../models/room_model.dart';

abstract class IRoomDatasource {
 Stream<List<Map>> getRooms();
 Future<void> add(RoomModel room, UserModel user);
 Future<void> delete(RoomModel room, UserModel user);
 Future<void> sendMessage(RoomModel room, MessageModel message);
 Stream<List<Map>> getMessages(RoomModel room);
 Stream<List<Map>> getParticipants(RoomModel room);

}
