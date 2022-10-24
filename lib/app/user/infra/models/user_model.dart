import 'dart:convert';

import '../../../user/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

 UserModel copyWith({
    String? idUser,
    String? nickname,
    int? age,
    String? genre,
    double? latitude,
    double? longitude,
    List<dynamic>? messages
 }) {
   return UserModel(
     idUser: idUser ?? super.idUser,
     nickname: nickname ?? super.nickname,
     age: age ?? super.age,
     genre: genre ?? super.genre,
     latitude: latitude ?? super.latitude,
     longitude: longitude ?? super.longitude,
     messages: messages ?? super.messages
   );
 }

 factory UserModel.empty() => UserModel(
   age: 0,
   genre: 'não informado',
   nickname: '',
   idUser: '',
   messages: [],
     latitude: 0.0,
     longitude: 0.0
 );
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
 static Map<String, dynamic> toMaps(List<dynamic> user) {
   return {

   };
 }

  static String toJson(UserEntity userEntity) => json.encode(UserModel.toMap(userEntity));

  static UserModel fromJson(String source) => fromMap(json.decode(source));
  UserModel({
    required String idUser,
    required String nickname,
    required int age,
    required String genre,
    required double latitude,
    required double longitude,
    required List<dynamic> messages
  }) : super(
        messages: messages,
        idUser: idUser,
        nickname: nickname,
        age: age,
        longitude: longitude,
        latitude: latitude,
        genre: genre);
}

