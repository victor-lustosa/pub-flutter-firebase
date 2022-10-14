import 'dart:convert';

import '../../user/infra/models/user_model.dart';

class Participant {

  late String _idUser = '';
  late String _nickname= '';
  late int _age = 0;
  late String _genre= '';
  late double _latitude = 0.0;
  late double _longitude = 0.0;
  List<dynamic> _messages = [];

  get getMessages => _messages;

  setMessages(List<dynamic> value) => _messages = value;

  addMessages(dynamic data) {
    _messages.add(data);
  }
  //GETTERS
  get getIdUser => _idUser;
  get getNickname => _nickname;
  get getAge => _age;
  get getGenre => _genre;
  get getLatitude => _latitude;
  get getLongitude => _longitude;

  Map<String, dynamic> toMap() {
    return {
      'idUser': this._idUser,
      'nickname': this._nickname,
      'age': this._age,
      'genre': this._genre,
      'latitude': this._latitude,
      'longitude': this._longitude,
    };
  }
  //SETTERS
  setIdUser(String idUser) => _idUser = idUser;
  setLatitude(double value) => _latitude = value;
  setLongitude(double value) => _longitude = value;
  setNickname(String nickname) => _nickname = nickname;
  setAge(int age) => _age = age;
  setGenre(String genre) => _genre = genre;

  Participant.withoutParameters();

  static List<Participant> convertList(json){
    List listParticipants = json as List;
    return listParticipants.map((data) => Participant.fromMap(data)).toList();
  }
  static convertUserToParticipant(UserModel user) {
    return Participant(
        idUser: user.idUser,
        nickname:  user.nickname,
        age: user.age,
        genre: user.genre,
        latitude: user.latitude,
        longitude: user.longitude
    );
  }
  factory Participant.fromMap(map) {
    return Participant(
        idUser: map['idUser'],
        nickname: map['nickname'],
        age: map['age'],
        genre: map['genre'],
        latitude: map['latitude'],
        longitude: map['longitude']
    );
  }
  String toJson() => json.encode(toMap());

  Participant({
    required idUser,
    required nickname,
    required age,
    required genre,
    required latitude,
    required longitude,
  })  : _idUser = idUser,
        _nickname = nickname,
        _age = age,
        _longitude = longitude,
        _latitude = latitude,
        _genre = genre;
}

