
import 'package:pub/app/room/infra/models/message_model.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../../user/infra/models/user_model.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/room_entity.dart';
class RoomModel extends RoomEntity {

  RoomModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    required double distance,
    required bool isAcceptedLocation,
    required List<UserEntity> participants,
    required List<MessageEntity> messages,
  }) : super(
    id: id,
    name: name,
    latitude: latitude,
    longitude: longitude,
    distance: distance,
    isAcceptedLocation: isAcceptedLocation,
    participants: participants,
    messages:messages
  );

  factory RoomModel.empty() => RoomModel(
      id: '',
      name: '',
      latitude: 0.0,
      longitude: 0.0,
      distance: 0.0,
      isAcceptedLocation: false,
      participants: [],
      messages: [],
  );

  addParticipants(UserEntity data) {
    participants.add(data);
  }

  removeParticipants(UserEntity data) {
    participants.removeWhere((element) => data.idUser == element.idUser);
  }

  RoomModel copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    double? distance,
    bool? isAcceptedLocation,
    List<UserEntity>? participants,
    List<MessageEntity>? messages,
  }) {
    return RoomModel(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        distance: distance ?? this.distance,
        isAcceptedLocation: isAcceptedLocation ?? this.isAcceptedLocation,
        participants: participants ?? this.participants,
        messages: messages ?? this.messages
    );
  }
}

