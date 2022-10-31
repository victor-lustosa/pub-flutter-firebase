
import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_datasource.dart';
import '../models/room_model.dart';

class RoomRepository implements IRoomRepository<RoomEntity> {
  final IRoomDatasource datasource;

  RoomRepository({required this.datasource});

  @override
  Stream<List<RoomEntity>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }

  @override
  Future<void> add(room, user) async {
    datasource.add(room, user);
  }

  @override
  Future<void> sendMessage() {
    return datasource.sendMessage();
  }

  @override
  Future<void> receiveMessage() {
    return datasource.receiveMessage();
  }

  @override
  Future<void> delete(room, user) async {
    datasource.delete(room, user);
  }

  List<RoomEntity> _convert(List<Map> list) {
    return list.map(RoomModel.fromMap).toList();
  }
}
