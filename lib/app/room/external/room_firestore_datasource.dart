import 'package:cloud_firestore/cloud_firestore.dart';
import '../../room/infra/datasources/room_datasource.dart';
import '../../user/infra/models/user_model.dart';
import '../infra/models/room_model.dart';

class RoomFirestoreDatasource implements IRoomDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource({required this.firestore});

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs.map((document) => {
      'id': document.id,
      ...document.data(),
    }).toList();
  }

  @override
  Stream<List<Map>> get() {
    final snapshot = firestore.collection('rooms').snapshots();
    return snapshot.map((room) => room.docs).map(_convert);
  }

  @override
  Future<void> add(RoomModel room, UserModel user) async {
    firestore.collection("rooms")
             .doc(room.id)
             .collection("participants")
             .doc(user.idUser)
             .set(UserModel.toMap(user));
  }

  @override
  Future<void> receiveMessage() {
    // TODO: implement receiveMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage() {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
//TODO:Alterar o model de Room pra colocar uma variavel que vai ter o numero de participantes,
// alterar metodos add para incrementar o valor do numero de participantes, pegar esse valor na tela
  @override
  Future<void> delete(RoomModel room, UserModel user) async {
    firestore.collection("rooms")
             .doc(room.id)
             .collection("participants")
             .doc(user.idUser)
             .delete()
             .then((value) => print("User Deleted"))
             .catchError((error) => print("Failed to delete user: $error"));
  }

}
