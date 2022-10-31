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

  const RoomEntity({
    required this.id,
    required this.isAcceptedLocation,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.participants
  });
}
