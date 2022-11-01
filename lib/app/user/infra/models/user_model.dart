
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
     idUser: idUser ?? this.idUser,
     nickname: nickname ?? this.nickname,
     age: age ?? this.age,
     genre: genre ?? this.genre,
     latitude: latitude ?? this.latitude,
     longitude: longitude ?? this.longitude,
     messages: messages ?? this.messages
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

