
import '../../../core/domain/repositories/get_repository.dart';
import '../../../core/infra/datasources/get_datasource.dart';

import '../../domain/entities/room_entity.dart';
import '../models/room_model.dart';

class RoomRepository implements IGetRepository<RoomModel> {
  final IGetDatasource datasource;

  RoomRepository(this.datasource);

  List<RoomModel> _convert(List<Map> list) {
    return list.map(RoomModel.fromMap).toList();
  }

  @override
  Stream<List<RoomModel>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }
}
