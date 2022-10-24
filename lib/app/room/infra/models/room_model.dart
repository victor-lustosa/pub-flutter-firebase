
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/infra/models/user_model.dart';
import '../../domain/entities/room_entity.dart';
import 'data/message_data.dart';
class RoomModel extends RoomEntity {

  RoomModel(
      {required String id,
        required String name,
        required double latitude,
        required double longitude,
        required bool isAcceptedLocation,
        required double distance,
        required List<UserEntity> participants,
        required List<dynamic> messages})
      : super(id: id,
              isAcceptedLocation: isAcceptedLocation,
              name: name,
              latitude: latitude,
              longitude: longitude,
              distance: distance,
              messages: messages,
              participants: participants
              );

  factory RoomModel.empty() =>
      RoomModel(id: '',
                name: '',
                isAcceptedLocation: false,
                latitude: 0.0,
                longitude: 0.0,
                participants: [],
                messages: [],
                distance: 0.0
                );

  RoomModel copyWith(
      {String? id,
        String? name,
        double? latitude,
        bool?  isAcceptedLocation,
        double? longitude,
        double? distance,
        List<UserEntity>? participants,
        List<dynamic>? messages
      }) {
    return RoomModel(
        id: id ?? super.id,
        isAcceptedLocation: isAcceptedLocation ?? super.isAcceptedLocation,
        name: name ?? super.name,
        latitude: latitude ?? super.latitude,
        longitude: longitude ?? super.longitude,
        distance: distance ?? super.distance,
        messages: messages ?? super.messages,
        participants: participants ?? super.participants,
        );
  }

  /*Room.fromMinimalMap(json)
      : this._idRoom = json['idRoom'],
        this._roomName = json['roomName'],
        this._latitude = json['latitude'],
        this._longitude = json['longitude'],
        this._participants = Participant.convertList(json['participants']);*/

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

  /*static Map<String, dynamic> toMap(RoomEntity room) {
    return {
      'id': room.id,
      'name': room.name,
      'latitude': room.latitude.toString(),
      'longitude': room.longitude.toString()
    };
  }*/
}

