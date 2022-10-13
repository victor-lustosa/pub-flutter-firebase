//import '../dtos/room_entity.dart';
import '../repositories/room_repository.dart';

abstract class ILeaveRoom {
  Future<void> call();
}

class LeaveRoom implements ILeaveRoom {
  final IRoomRepository repository;

  LeaveRoom(this.repository);

  @override
  Future<void> call() {
    return repository.leaveRoom();
  }
}
