

import '../entities/user_entity.dart';

abstract class IUserRepository {
  Stream<List<UserEntity>> saveUser();
}
