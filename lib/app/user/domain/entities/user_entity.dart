class UserEntity {
  final String idUser;
  final String nickname;
  final int age;
  final String genre;
  final double latitude;
  final double longitude;
  final List<dynamic> messages;

  UserEntity({
    required this.idUser,
    required this.nickname,
    required this.age,
    required this.genre,
    required this.latitude,
    required this.longitude,
    required this.messages
  });
}