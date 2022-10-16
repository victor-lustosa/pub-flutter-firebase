
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

abstract class ISaveUser {
  Stream<List<UserEntity>> call();
}

class SaveUser implements ISaveUser {
  final IUserRepository repository;

  SaveUser(this.repository);

  @override
  Stream<List<UserEntity>> call() {
    return repository.saveUser();
  }
}
