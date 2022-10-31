
import '../../../core/domain/repositories/repository.dart';

abstract class IRoomRepository <T> implements IGetRepository<T>{
  Future<void> add(T,P);
  Future<void> sendMessage();
  Future<void> receiveMessage();
  Future<void> delete(T,P);

}
