import 'package:cloud_firestore/cloud_firestore.dart';
import '../infra/datasources/participant_datasource.dart';

class RoomFirestoreDatasource implements IParticipantDatasource {
  final FirebaseFirestore firestore;

  RoomFirestoreDatasource({required this.firestore});

  @override
  Future<void> add(user) {
    // TODO: implement add
    throw UnimplementedError();
  }
}
