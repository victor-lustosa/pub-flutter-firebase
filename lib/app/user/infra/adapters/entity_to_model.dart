
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class EntityToModel{
  static UserModel user(UserEntity user) {
    return UserModel(
        age: user.age,
        genre: user.genre,
        nickname: user.nickname,
        idUser: user.idUser,
        messages: user.messages,
        latitude: user.latitude,
        longitude: user.longitude
    );
  }
}