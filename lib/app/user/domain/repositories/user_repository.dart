import '../../../core/domain/repositories/repository.dart';

import '../entities/user_entity.dart';

abstract class IUserRepository<T>
    implements IAddRepository<T>, IUpdateRepository<T>, IDeleteRepository<T> {
  UserEntity get();
}
