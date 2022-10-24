import 'package:cloud_firestore/cloud_firestore.dart';
import '../../room/infra/datasources/room_datasource.dart';

class RoomFirestoreDatasource implements IRoomDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource(this.firestore);

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
}
