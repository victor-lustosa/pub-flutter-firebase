import '../../../../user/infra/models/user_model.dart';
import '../data/data.dart';
import '../../../blocs/bloc_events.dart';

class PublicRoomData extends Data{
  late String idRoom;
  late String roomName;
  late int code;
  late UserModel user;
  late String textMessage;



  Map<String, dynamic> toMap() {
    return {
      'idRoom': this.idRoom,
      'roomName': this.roomName,
      'textMessage': this.textMessage,
      'user': UserModel.toMap(this.user),
      'code': this.code,
      'type': super.type.name.toString()
    };
  }

  factory PublicRoomData.fromMap(Map<String, dynamic> map) {
    return PublicRoomData(
        idRoom: map['idRoom'],
        roomName: map['roomName'],
        textMessage: map['textMessage'],
        user: UserModel.fromMap(map['user']),
        code: map['code'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }

  PublicRoomData({
    required String idRoom,
    required String roomName,
    required String textMessage,
    required user,
    required int code,
    required type,
  })  : idRoom = idRoom,
        roomName = roomName,
        textMessage = textMessage,
        user = user,
        code = code,
        super(type: type);
}