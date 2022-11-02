import 'dart:convert';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class UserAdapter{
  static UserModel fromMap(dynamic map) {
    return UserModel(
        idUser: map['idUser'],
        nickname: map['nickname'],
        age: map['age'],
        genre: map['genre'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        messages: []
    );
  }
  static Map<String, dynamic> toMap(UserEntity user) {
    return {
      'idUser': user.idUser,
      'nickname': user.nickname,
      'age': user.age,
      'genre': user.genre,
      'latitude': user.latitude,
      'longitude': user.longitude,
    };
  }
  static Map<String, dynamic> toMapList(UserEntity user) {
    return {
      'idUser': user.idUser,
      'nickname': user.nickname,
      'age': user.age,
      'genre': user.genre,
      'latitude': user.latitude,
      'longitude': user.longitude,
    };
  }


  static String toJson(UserEntity userEntity) => json.encode(UserAdapter.toMap(userEntity));

  static UserModel fromJson(String source) => fromMap(json.decode(source));

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