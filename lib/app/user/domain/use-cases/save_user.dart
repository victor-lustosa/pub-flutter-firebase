
import 'package:pub/app/user/domain/repositories/user_repository.dart';
import '../entities/user_entity.dart';


abstract class ISaveUser {
  void add(UserEntity userModel);
}

class SaveUser implements ISaveUser {
  final IUserRepository<UserEntity> repository;

  SaveUser(this.repository);

  @override
  Future<void> add(UserEntity userModel) async{
    return repository.add(userModel);
  }
}
