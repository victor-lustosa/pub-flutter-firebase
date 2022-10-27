abstract class IGetDatasource {
  Stream<List<Map>> get();
}
abstract class IAddDatasource<T> {
  Future<void> add(T);
}
abstract class IDeleteDatasource<T> {
  Future<void> delete(T);
}
abstract class IUpdateDatasource<T> {
  Future<void> update(T);
}

