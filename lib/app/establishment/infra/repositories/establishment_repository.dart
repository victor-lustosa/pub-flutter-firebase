import '../../../room/infra/models/room_model.dart';
import '../../../room/domain/entities/room_entity.dart';
import '../../domain/repositories/establishment_repository.dart';
import '../datasources/establishment_datasource.dart';

class EstablishmentRepository implements IEstablishmentRepository<RoomEntity> {
  final IEstablishmentDatasource datasource;

  EstablishmentRepository({required this.datasource});

  List<RoomEntity> _convert(List<Map> list) {
    return list.map(RoomModel.fromMap).toList();
  }
  @override
  Stream<List<RoomEntity>> get() {
    final stream = datasource.get();
    return stream.map(_convert);
  }

}
