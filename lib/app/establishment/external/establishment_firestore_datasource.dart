import 'package:cloud_firestore/cloud_firestore.dart';

import '../infra/datasources/establishment_datasource.dart';

class EstablishmentFirestoreDatasource implements IEstablishmentDatasource {
  final FirebaseFirestore firestore;

  EstablishmentFirestoreDatasource(this.firestore);

  List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
  }

  @override
  Stream<List<Map>> getEstablishments() {
    final snapshot = firestore.collection('establishments').snapshots();

    return snapshot.map((establishment) => establishment.docs).map(_convert);
  }
}
