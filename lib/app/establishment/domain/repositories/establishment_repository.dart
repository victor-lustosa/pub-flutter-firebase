import '../entities/establishment_entity.dart';

abstract class IEstablishmentRepository {
  Stream<List<EstablishmentEntity>> getEstablishments();
}
