
import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_datasource.dart';
import '../models/room_model.dart';

class RoomRepository implements IRoomRepository<RoomEntity> {
  final IRoomDatasource datasource;

  RoomRepository(this.datasource);

  List<RoomEntity> _convert(List<Map> list) {
    return list.map(RoomModel.fromMap).toList();
  }

  @override
  Future<void> add(room, user) async {
    datasource.add(room, user);
  }
  @override
  Stream<List<RoomEntity>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }

  @override
  Future<void> leaveRoom() {
    // TODO: implement leaveRoom
    throw UnimplementedError();
  }

  @override
  Future<void> receiveMessage() {
    // TODO: implement receiveMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage() {
    // TODO: implement sendPublicMessage
    throw UnimplementedError();
  }

}
