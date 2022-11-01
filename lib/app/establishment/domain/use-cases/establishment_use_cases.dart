
import '../../../room/domain/entities/room_entity.dart';
import '../repositories/establishment_repository.dart';

abstract class IEstablishmentUseCases {
  Stream<List<RoomEntity>> getRooms();
 // Future<dynamic> getStream();
}

class EstablishmentUseCases implements IEstablishmentUseCases {
  final IEstablishmentRepository<RoomEntity> repository;

  EstablishmentUseCases({required this.repository});

  @override
  Stream<List<RoomEntity>> getRooms() {
    return repository.get();
  }
 /* @override
  Future<dynamic> getStream(){
    return repository.getStream();
  }*/
}
