import '../../../../room/blocs/bloc_events.dart';
import '../../../../user/infra/models/user_model.dart';

abstract class Data {

  final String id;
  final BlocEventType type;

  Data({required this.type, required this.id});
}

abstract class MessageData extends Data {

  final String createdAt;
  final String textMessage;
  final UserModel user;

  MessageData({
    required this.createdAt,
    required this.textMessage,
    required this.user,
    required String id,
    required BlocEventType type,
    }) :
     super(id: id, type: type);
}

class StateMessageData extends Data{

  final String idRoom;
  final UserModel user;

  StateMessageData({
    required this.idRoom,
    required this.user,
    required String id,
    required BlocEventType type,
  }) :
        super(id: id, type: type);
}
class PublicRoomMessageData extends MessageData{
  final String idRoom;
  final String roomName;

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'idRoom': this.idRoom,
      'roomName': this.roomName,
      'createdAt': super.createdAt,
      'textMessage': super.textMessage,
      'type': super.type.name.toString(),
      'user': UserModel.toMap(super.user)
    };
  }

  factory PublicRoomMessageData.fromMap(dynamic map) {
    return PublicRoomMessageData(
        id: map['id'],
        idRoom: map['idRoom'],
        roomName: map['roomName'],
        createdAt: map['createAt'],
        textMessage: map['textMessage'],
        user: UserModel.fromMap(map['user']),
        code: map['code'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }

  PublicRoomMessageData({
    required this.roomName,
    required this.idRoom,
    required String id,
    required String createdAt,
    required String textMessage,
    required UserModel user,
    required int code,
    required BlocEventType type,
  }) : super(type: type,
            id: id,
            user: user,
            createdAt: createdAt,
            textMessage: textMessage);
}

class PrivateRoomMessageData extends MessageData{

  Map<String, dynamic> toMap() {
    return {
      'idRoom': super.id,
      'roomName': super.createdAt,
      'textMessage': super.textMessage,
      'user': UserModel.toMap(super.user),
      'type': super.type.name.toString()
    };
  }

  factory PrivateRoomMessageData.fromMap(Map<String, dynamic> map) {
    return PrivateRoomMessageData(
        id: map['id'],
        textMessage: map['textMessage'],
        user: UserModel.fromMap(map['user']),
        createdAt: map['createdAt'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }

  PrivateRoomMessageData({
    required String id,
    required String textMessage,
    required UserModel user,
    required String createdAt,
    required BlocEventType type,
  }) : super(type: type,
             id: id,
             textMessage: textMessage,
             createdAt: createdAt,
             user: user);

}
/*class DeleteMessageData extends Data{

  late String roomName;
  late String userNickName;

  DeleteMessageData({
    required this.roomName,
    required this.userNickName,
    required BlocEventType type,
    required String id}) : super(type: type, id: id);

  Map<String, dynamic> toMap() {
    return {
      'roomName': this.roomName,
      'userNickName': this.userNickName,
      'type': super.type.toString(),
    };
  }

  factory DeleteMessageData.fromMap(Map<String, dynamic> map) {
    return DeleteMessageData(
        roomName: map['roomName'],
        userNickName: map['userNickName'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }
}
class EditMessageData extends Data{
  EditMessageData({required super.type});
}*/
/*class StoppedTypingData extends Data{

  final String roomName;
  final String userNickName;

  StoppedTypingData({required this.roomName, required this.userNickName,required BlocEventType type}) : super(type: type);

  Map<String, dynamic> toMap() {
    return {
      'roomName': this.roomName,
      'userNickName': this.userNickName,
      'type': super.type.toString(),
    };
  }

  factory StoppedTypingData.fromMap(Map<String, dynamic> map) {
    return StoppedTypingData(
        roomName: map['roomName'],
        userNickName: map['userNickName'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }
}

class TypingData extends Data{

  final String roomName;
  final String userNickName;

  TypingData({required this.roomName, required this.userNickName,required BlocEventType type}) : super(type: type);

  Map<String, dynamic> toMap() {
    return {
      'roomName': this.roomName,
      'userNickName': this.userNickName,
      'type': super.type.toString(),
    };
  }

  factory TypingData.fromMap(Map<String, dynamic> map) {
    return TypingData(
        roomName: map['roomName'],
        userNickName: map['userNickName'],
        type: BlocEventType.values.firstWhere((element) => element.name.toString() == map['type']));
  }
}*/
