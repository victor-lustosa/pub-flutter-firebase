
abstract class IRoomRepository <T> {
  Future<void> add(T,P);
  Future<void> sendMessage(T,P);
  Future<void> receiveMessage(T,P);
  Future<void> delete(T,P);

}
