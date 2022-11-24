import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../models/room_model.dart';
import 'message_adapter.dart';

class RoomAdapter{
  static RoomModel fromMap(dynamic json) {
    return RoomModel(
      isAcceptedLocation: false,
      id: json['id'],
      name: json['name'],
      latitude: double.parse(json['latitude'],),
      longitude: double.parse(json['longitude'],),
      distance: 0.0,
      participants: [
        if (json.containsKey('participants'))
          ...(json['participants'] as List).map(UserAdapter.fromMap).toList(),
      ],
      messages: [
        if (json.containsKey('messages'))
          ...(json['messages'] as List).map(MessageAdapter.fromMap).toList(),
      ],
    );
  }
}