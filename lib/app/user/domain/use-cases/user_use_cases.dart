
import '../../../user/blocs/location_permission_enum.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../entities/user_entity.dart';


abstract class IUserUseCases {
  Future<void> add(UserEntity user);
  Future<UserEntity?> get();
  Future<LocationPermissionEnum> checkAccessToLocation();
  Future<void> update(UserEntity user);
  Future<void> delete(UserEntity user);
}

class UserUseCases implements IUserUseCases {
  final IUserRepository<UserEntity> repository;

  UserUseCases({required this.repository});

  @override
  Future<UserEntity?> get() async {
    return repository.get();
  }

  @override
  Future<void> add(UserEntity user) async {
    return repository.add(user);
  }

  @override
  Future<LocationPermissionEnum> checkAccessToLocation() async{
    return repository.checkAccessToLocation();
  }

  @override
  Future<void> delete(UserEntity user) async {
    return repository.delete(user);
  }

  @override
  Future<void> update(UserEntity user) async {
    return repository.update(user);
  }



}
