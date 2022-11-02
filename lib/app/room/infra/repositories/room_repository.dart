
import 'package:pub/app/room/infra/adapters/room_adapter.dart';

import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_datasource.dart';

class RoomRepository implements IRoomRepository<RoomEntity> {
  final IRoomDatasource datasource;

  RoomRepository({required this.datasource});

  List<RoomEntity> _convert(List<Map> list) {
    return list.map(RoomAdapter.fromMap).toList();
  }

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
  Future<void> sendMessage(room, user) {
    return datasource.sendMessage(room, user);
  }

  @override
  Future<void> receiveMessage(room, user) {
    return datasource.receiveMessage(room, user);
  }

  @override
  Future<void> delete(room, user) async {
    datasource.delete(room, user);
  }
}
