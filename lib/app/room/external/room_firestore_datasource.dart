import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../../room/infra/datasources/room_datasource.dart';
import '../../user/infra/models/user_model.dart';
import '../infra/models/room_model.dart';

class RoomFirestoreDatasource implements IRoomDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource({required this.firestore});

  @override
  Future<void> add(RoomModel room, UserModel user) async {
    firestore.collection("rooms")
             .doc(room.id)
             .set(UserAdapter.toMap(user));
  }

  @override
  Future<void> receiveMessage(RoomModel room, UserModel user) async {
    firestore.collection("rooms")
        .doc(room.id)
        .collection("messages")
        .doc(user.idUser)
        .set(UserAdapter.toMap(user));
  }

  @override
  Future<void> sendMessage(RoomModel room, UserModel user) async {
    firestore.collection("rooms")
        .doc(room.id)
        .collection("messages")
        .doc(user.idUser)
        .set(UserAdapter.toMap(user));
  }
//TODO:Alterar o model de Room pra colocar uma variavel que vai ter o numero de participantes,
// alterar metodos add para incrementar o valor do numero de participantes, pegar esse valor na tela
  @override
  Future<void> delete(RoomModel room, UserModel user) async {
   // firestore.collection("rooms")
    //         .doc(room.id)
   //          .update({'participants':FieldValue.arrayUnion(user)});

  }

}
