
import '../../../room/domain/repositories/room_repository.dart';
import '../../../room/infra/datasources/room_datasource.dart';
import '../../../user/infra/models/user_model.dart';

/*class RoomRepository  {
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
  Future<void> receiveMessage(T, P) {
    // TODO: implement receiveMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(T, P) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<void> delete(T, P) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
*/