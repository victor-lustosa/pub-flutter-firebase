import '../../../core/infra/datasources/datasource.dart';

abstract class IUserDatasource<T>
    implements IAddDatasource, IDeleteDatasource, IUpdateDatasource {
  Future<String?> get();
  checkAccessToLocation();
}
