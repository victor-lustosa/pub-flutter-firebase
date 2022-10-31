
import '../../../core/infra/datasources/datasource.dart';
import '../../../user/infra/models/user_model.dart';
import '../models/room_model.dart';

abstract class IRoomDatasource implements IGetDatasource{
 Future<void> add(RoomModel room, UserModel user);
 Future<void> delete(RoomModel room, UserModel user);
 Future<void> sendMessage();
 Future<void> receiveMessage();
}
