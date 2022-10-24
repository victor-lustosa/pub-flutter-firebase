abstract class IUpdateRepository <T>{
  Future<void> update(T);
}