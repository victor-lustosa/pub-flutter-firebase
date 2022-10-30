
import 'package:pub/app/room/domain/repositories/room_repository.dart';
import 'package:pub/app/room/infra/datasources/room_datasource.dart';

import '../../../user/infra/models/user_model.dart';

class RoomRepository implements IRoomRepository<UserModel> {
  final IRoomDatasource datasource;

  RoomRepository({required this.datasource});

  List<UserModel> _convert(List<Map> list) {
    return list.map(UserModel.fromMap).toList();
  }

  @override
  Stream<List<UserModel>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }

  @override
  Future<void> add(T, P) {
    // TODO: implement add
    throw UnimplementedError();
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
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
