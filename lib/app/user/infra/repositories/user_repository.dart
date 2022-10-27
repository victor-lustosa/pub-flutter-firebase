import 'dart:convert';

import '../../blocs/location_permission_enum.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';
import '../models/user_model.dart';

class UserRepository implements IUserRepository<UserEntity> {
  final IUserDatasource<UserEntity> datasource;

  UserRepository({required this.datasource});

  @override
  Future<UserEntity?> get() {
    final data = datasource.get();
    var user;
    data.then((value) => {
          if (value != null) {
            user = UserModel.fromMap(jsonDecode(value))
          }
        }
    );
    return Future.value(user);
  }

  @override
  Future<void> add(user) async {
    return datasource.add(user);
  }

  @override
  Future<void> delete(user) async {
    return datasource.delete(user);
  }

  @override
  Future<void> update(user) async {
    return datasource.update(user);
  }

  @override
  Future<LocationPermissionEnum> checkAccessToLocation() {
    return datasource.checkAccessToLocation();
  }
}
