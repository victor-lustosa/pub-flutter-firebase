
import '../../../core/infra/datasources/get_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repositories.dart';

class UserRepository implements IUserRepository <UserEntity> {
  final IGetDatasource datasource;

  UserRepository(this.datasource);

  @override
  UserEntity get() {
   return UserEntity(
       idUser: '',
       nickname: '',
       age: 0,
       genre: '',
       latitude: 0.0,
       longitude: 0.0,
       messages: []
   );
  }

  @override
  Future<void> add(T) async {
    // TODO: implement add
  }

  @override
  Future<void> delete(T) async {
    // TODO: implement delete
  }

  @override
  Future<void> update(T) async {
    // TODO: implement update
  }

}
