import 'package:cloud_firestore/cloud_firestore.dart';
import '../infra/datasources/participant_datasource.dart';

class RoomFirestoreDatasource implements IParticipantDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource(this.firestore);

  @override
  Stream<List<Map>> add() {
    // TODO: implement add
    throw UnimplementedError();
  }
}
