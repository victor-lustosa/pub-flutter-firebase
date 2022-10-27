import '../../../core/domain/repositories/repository.dart';

abstract class IUserRepository<T>
    implements IAddRepository<T>, IUpdateRepository<T>, IDeleteRepository<T> {
  Future<T?> get();

  checkAccessToLocation();
}
