
import '../../../core/domain/repositories/get_repository.dart';
import '../../infra/models/room_model.dart';
import '../entities/room_entity.dart';

abstract class IGetRooms {
  Stream<List<RoomModel>> call();
}

class GetRooms implements IGetRooms {
  final IGetRepository<RoomModel> repository;

  GetRooms(this.repository);

  @override
  Stream<List<RoomModel>> call() {
    return repository.get();
  }
}
