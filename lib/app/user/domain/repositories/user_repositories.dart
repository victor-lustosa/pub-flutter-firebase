import '../../../core/domain/repositories/add_repository.dart';
import '../../../core/domain/repositories/delete_repository.dart';
import '../../../core/domain/repositories/update_repository.dart';
import '../entities/user_entity.dart';

abstract class IUserRepository<T>
    implements IAddRepository<T>, IUpdateRepository<T>, IDeleteRepository<T> {
  UserEntity get();
}
