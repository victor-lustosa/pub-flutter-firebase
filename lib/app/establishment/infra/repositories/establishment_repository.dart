import 'package:pub/app/establishment/domain/entities/establishment_entity.dart';

import '../../domain/repositories/establishment_repository.dart';
import '../datasources/establishment_datasource.dart';
import '../models/establishment_model.dart';

class EstablishmentRepository implements IEstablishmentRepository {
  final IEstablishmentDatasource datasource;

  EstablishmentRepository(this.datasource);

  List<EstablishmentEntity> _convert(List<Map> list) {
    return list.map(EstablishmentModel.fromMap).toList();
  }

  @override
  Stream<List<EstablishmentEntity>> getEstablishments() {
    final stream = datasource.getEstablishments();

    return stream.map(_convert);
  }
}
