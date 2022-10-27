import 'package:pub/app/user/infra/datasources/user_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserSharedDatasource<T> implements IUserDatasource<T>{

  @override
  Future<String?> get() async{
    final shared = await SharedPreferences.getInstance();
    return shared.getString('user');
  }

  @override
  Future<void> add(T) {
    // TODO: implement add
    throw UnimplementedError();
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