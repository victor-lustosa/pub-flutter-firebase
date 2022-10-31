import 'dart:async';
import '../../room/domain/entities/room_entity.dart';
import '../../user/domain/entities/user_entity.dart';
import '../../user/infra/models/user_model.dart';
import '../infra/datasources/room_datasource.dart';
import '../infra/models/room_model.dart';

class RoomFunctionsDatasource implements IRoomDatasource {
  // final Dio dio;

  //RoomFunctionsDatasource(this.dio);

  // List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  //   return;'
  //}


  @override
  Future<void> add(RoomEntity room, UserEntity user) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(RoomModel room, UserModel user) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> receiveMessage(RoomModel room, UserModel user) {
    // TODO: implement receiveMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(RoomModel room, UserModel user) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
