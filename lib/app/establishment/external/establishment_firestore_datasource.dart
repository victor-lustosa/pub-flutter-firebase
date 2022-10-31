import 'package:cloud_firestore/cloud_firestore.dart';
import '../infra/datasources/establishment_datasource.dart';


class EstablishmentFirestoreDatasource implements IEstablishmentDatasource {
  final FirebaseFirestore firestore;

  EstablishmentFirestoreDatasource({required this.firestore});

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

}
