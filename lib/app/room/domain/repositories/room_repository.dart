
import '../../../core/domain/repositories/repository.dart';

abstract class IRoomRepository <T> implements IGetRepository<T>{
  Future<void> add(T,P);
  Future<void> sendMessage(T,P);
  Future<void> receiveMessage(T,P);
  Future<void> delete(T,P);

}
