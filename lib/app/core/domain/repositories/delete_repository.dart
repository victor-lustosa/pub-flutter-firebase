abstract class IDeleteRepository <T>{
  Future<void> delete(T);
}