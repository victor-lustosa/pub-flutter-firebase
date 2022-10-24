
import '../../../core/domain/repositories/add_repository.dart';
import '../entities/user_entity.dart';


abstract class ISaveUser {
  void call(UserEntity userModel);
}

class SaveUser implements ISaveUser {
  final IAddRepository repository;

  SaveUser(this.repository);

  @override
  Future<void> call(UserEntity userModel) async{
    return repository.add(userModel);
  }
}
