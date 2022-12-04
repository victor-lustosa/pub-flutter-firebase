import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../../room/infra/datasources/room_datasource.dart';
import '../../user/infra/models/user_model.dart';
import '../infra/adapters/message_adapter.dart';
import '../infra/models/message_model.dart';
import '../infra/models/room_model.dart';

class RoomFirestoreDatasource implements IRoomDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource({required this.firestore});

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
  }

  @override
  Stream<List<Map>> getRooms() {
    final snapshot = firestore.collection('rooms').snapshots();
    return snapshot.map((room) => room.docs).map(_convert);
  }

  @override
  Future<void> add(RoomModel room, UserModel user) async {
    firestore
        .collection("rooms")
        .doc(room.id)
        .collection("participants")
        .doc(user.idUser)
        .set(
          UserAdapter.toMap(user),
        );
  }

  @override
  Future<void> sendMessage(RoomModel room, MessageModel message) async {
    firestore
        .collection("rooms")
        .doc(room.id)
        .collection("messages")
        .doc(message.id)
        .set(
          MessageAdapter.toMap(message),
        );
  }

  @override
  Stream<List<Map>> getMessages(RoomModel room) {
    final snapshot = firestore.collection('rooms').doc(room.id).collection('messages').snapshots();
    return snapshot.map((message) => message.docs).map(_convert);
  }

  @override
  Stream<List<Map>> getParticipants(RoomModel room) {
    final snapshot = firestore.collection('rooms').doc(room.id).collection('participants').snapshots();
    return snapshot.map((message) => message.docs).map(_convert);
  }

//TODO:Alterar o model de Room pra colocar uma variavel que vai ter o numero de participantes,
// alterar metodos add para incrementar o valor do numero de participantes, pegar esse valor na tela
  @override
  Future<void> delete(RoomModel room, UserModel user) async {
    firestore.collection("rooms").doc(room.id).update(
      {
        'participants': FieldValue.arrayRemove(
          [
            UserAdapter.toMap(user),
          ],
        ),
      },
    );
  }
}
