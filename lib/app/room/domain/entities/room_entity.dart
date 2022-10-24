import '../../../user/domain/entities/user_entity.dart';

class RoomEntity {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double distance;
  final bool isAcceptedLocation;
  // final String icon;
  final List<UserEntity> participants;
  final List<dynamic> messages;

  addMessages(dynamic data) {
    messages.add(data);
  }

  addParticipants(UserEntity data) {
    participants.add(data);
  }

  removeParticipants(UserEntity data) {
    participants.removeWhere((element) => data.idUser == element.idUser);
  }
  const RoomEntity({
    required this.id,
    required this.isAcceptedLocation,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.participants,
    required this.messages,
  });
}
