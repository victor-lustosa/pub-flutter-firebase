
import 'package:pub/app/room/infra/adapters/room_adapter.dart';
import '../../../user/infra/adapters/user_adapter.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../adapters/message_adapter.dart';
import '../datasources/room_datasource.dart';

class RoomRepository implements IRoomRepository<RoomEntity> {
  final IRoomDatasource datasource;

  RoomRepository({required this.datasource});

  List<RoomEntity> _roomConverter(List<Map> list) {
    return list.map(RoomAdapter.fromMap).toList();
  }
  List<MessageEntity> _messageConverter(List<Map> list) {
    return list.map(MessageAdapter.fromMap).toList();
  }
  List<UserEntity> _userConverter(List<Map> list) {
    return list.map(UserAdapter.fromMap).toList();
  }

  @override
  Stream<List<RoomEntity>> getRooms() {
    final stream = datasource.getRooms();
    return stream.map(_roomConverter);
  }

  @override
  Stream<List<MessageEntity>> getMessages(room) {
    final stream = datasource.getMessages(room);
    return stream.map(_messageConverter);
  }

  @override
  Stream<List<UserEntity>> getParticipants(room) {
    final stream = datasource.getParticipants(room);
    return stream.map(_userConverter);
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
  Future<void> delete(room, user) async {
    datasource.delete(room, user);
  }
}
