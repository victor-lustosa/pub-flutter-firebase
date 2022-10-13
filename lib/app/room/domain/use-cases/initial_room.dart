//import '../dtos/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class IInitialRoom {
  Future<void> call();
}

class InitialRoom implements IInitialRoom {
  final IRoomRepository repository;

  InitialRoom(this.repository);

  @override
  Future<void> call() {
    return repository.enterTheRoom();
  }
}
