import 'package:cloud_firestore/cloud_firestore.dart';
import '../../room/infra/datasources/room_datasource.dart';
import '../../user/infra/models/user_model.dart';
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
  Stream<List<Map>> get() {
    final snapshot = firestore.collection('rooms').snapshots();

    return snapshot.map((room) => room.docs).map(_convert);
  }

  @override
  Future<void> add(RoomModel room, UserModel user) async {
    firestore.collection("rooms").doc(room.id).collection("participants").add(UserModel.toMap(user));
  }
}
