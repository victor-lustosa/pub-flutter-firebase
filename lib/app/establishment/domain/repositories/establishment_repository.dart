import '../dtos/establishment_entity.dart';

abstract class IEstablishmentRepository {
  Stream<List<EstablishmentEntity>> getEstablishments();
}
