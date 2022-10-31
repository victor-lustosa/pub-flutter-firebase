import 'dart:async';
import '../domain/entities/room_entity.dart';
import '../../user/domain/entities/user_entity.dart';
import '../infra/datasources/room_datasource.dart';

class RoomFunctionsDatasource implements IRoomDatasource {
  // final Dio dio;

  //RoomFunctionsDatasource(this.dio);

  // List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  //   return;'
  //}

  @override
  Stream<List<Map>> get() {
    //   final valorRetornado = dio.get('url/exemplo');
    StreamController<List<Map>> exemplo = StreamController<List<Map>>();

    return exemplo.stream;
  }

  @override
  Future<void> add(RoomEntity room, UserEntity user) {
    // TODO: implement add
    throw UnimplementedError();
  }
}
