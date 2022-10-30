import 'package:pub/app/user/infra/datasources/user_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infra/models/user_model.dart';
class UserSharedDatasource<T> implements IUserDatasource<T>{
  final SharedPreferences _shared;

  UserSharedDatasource({required SharedPreferences shared}):_shared = shared;
  @override
  Future<String?> get() async{
    return _shared.getString('user');
  }

  @override
  Future<void> add(user) async {
    try {
      _shared.setString('user', UserModel.toJson(user));
    } catch (e) {
      throw Exception("Erro ao salvar usuario: $e");
    }
  }

  @override
  checkAccessToLocation() {
    // TODO: implement checkAccessToLocation
    throw UnimplementedError();
  }

  @override
  Future<void> delete(T) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update(T) {
    // TODO: implement update
    throw UnimplementedError();
  }


}