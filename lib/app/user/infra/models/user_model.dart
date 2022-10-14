import 'dart:convert';

import 'package:pub/app/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

 UserModel copyWith({
    String? idUser,
    String? nickname,
    int? age,
    String? genre,
    double? latitude,
    double? longitude,
 }) {
   return UserModel(
     idUser: idUser ?? this.idUser,
     nickname: nickname ?? this.nickname,
     age: age ?? this.age,
     genre: genre ?? this.genre,
     latitude: latitude ?? this.latitude,
     longitude: longitude ?? this.longitude
   );
 }
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUser: map['idUser'],
      nickname: map['nickname'],
      age: map['age'],
      genre: map['genre'],
      latitude: map['latitude'],
      longitude: map['longitude']
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

  static String toJson(UserEntity userEntity) => json.encode(UserModel.toMap(userEntity));

  static UserModel fromJson(String source) => fromMap(json.decode(source));
  UserModel({
    required idUser,
    required nickname,
    required age,
    required genre,
    required latitude,
    required longitude,
  })  :super(idUser: idUser,
        nickname : nickname,
        age : age,
        longitude :longitude,
        latitude : latitude,
        genre : genre);
}

