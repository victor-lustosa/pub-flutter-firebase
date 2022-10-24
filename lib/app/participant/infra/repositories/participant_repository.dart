
import '../../../core/domain/repositories/repository.dart';
import '../../../core/infra/datasources/datasource.dart';
import '../../../user/infra/models/user_model.dart';

class RoomRepository implements IGetRepository<UserModel> {
  final IGetDatasource datasource;

  RoomRepository(this.datasource);

  List<UserModel> _convert(List<Map> list) {
    return list.map(UserModel.fromMap).toList();
  }

  @override
  Stream<List<UserModel>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }
}
