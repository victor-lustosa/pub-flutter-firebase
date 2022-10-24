
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/infra/models/user_model.dart';
import '../../domain/entities/room_entity.dart';
import 'data/message_data.dart';
class RoomModel extends RoomEntity {

  RoomModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    required double distance,
    required bool isAcceptedLocation,
    required List<UserEntity> participants,
    required List<dynamic> messages
  }) : super(
    id: id,
    name: name,
    latitude: latitude,
    longitude: longitude,
    distance: distance,
    isAcceptedLocation: isAcceptedLocation,
    participants: participants,
    messages: messages
  );

  factory RoomModel.empty() => RoomModel(
      id: '',
      name: '',
      latitude: 0.0,
      longitude: 0.0,
      distance: 0.0,
      isAcceptedLocation: false,
      participants: [],
      messages: []
  );
  addMessages(dynamic data) {
    messages.add(data);
  }

  addParticipants(UserEntity data) {
    participants.add(data);
  }

  removeParticipants(UserEntity data) {
    participants.removeWhere((element) => data.idUser == element.idUser);
  }
  static RoomModel fromMap(dynamic json) {
    return RoomModel(
      isAcceptedLocation: false,
      id: json['id'],
      name: json['name'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      messages: [
        if (json.containsKey('messages'))
          ...(json['messages'] as List).map(MessageData.fromMap).toList(),
      ],
      participants: [],
      distance: 0.0,
    );
  }
  static Map<String, dynamic> toMap(RoomEntity room) {
    return{
      'id': room.id,
      'name': room.name,
      'latitude': room.latitude,
      'longitude': room.longitude,
      'distance': room.distance,
      'participants':  UserModel.toMaps(room.participants),
      'messages': UserModel.toMaps(room.messages)
    };
  }
  RoomModel copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    double? distance,
    bool? isAcceptedLocation,
    List<UserEntity>? participants,
    List<dynamic>? messages
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

