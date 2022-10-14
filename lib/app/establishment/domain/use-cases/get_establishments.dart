import 'package:pub/app/establishment/domain/repositories/establishment_repository.dart';

import '../entities/establishment_entity.dart';

abstract class IGetEstablishments {
  Stream<List<EstablishmentEntity>> call();
}

class GetEstablishments implements IGetEstablishments {
  final IEstablishmentRepository repository;

  GetEstablishments(this.repository);

  @override
  Stream<List<EstablishmentEntity>> call() {
    return repository.getEstablishments();
  }
}
