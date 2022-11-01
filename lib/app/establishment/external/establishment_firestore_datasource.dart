import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../room/infra/datasources/room_datasource.dart';
import '../../user/infra/models/user_model.dart';
import '../infra/datasources/establishment_datasource.dart';


class EstablishmentFirestoreDatasource implements IEstablishmentDatasource {
  final FirebaseFirestore firestore;
  var event;
  EstablishmentFirestoreDatasource({required this.firestore});

  /*Future<QuerySnapshot<Map<String, dynamic>>> entityStream(){
    final snapshot = firestore.collection('rooms').snapshots();
    snapshot.listen((event) {
      this.event = event;
    });
    return this.event;
  }
*/
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

  /*Stream<List<Map>> get() {
    final snapshot = firestore.collection('rooms').snapshots();
   // firestore.collection('rooms').doc().update({'data':FieldValue.arrayUnion(elements)});
    return snapshot.map((room) => room.docs).map(_convert);
  }*/

}
/*late final _roomStream;
final FirebaseFirestore firestore;

EstablishmentFirestoreDatasource({required this.firestore}){
  _roomStream  = StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();
}

List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  return docs.map((document) => {
    'id': document.id,
    ...document.data(),
  }).toList();
}

@override
Stream<List<Map>> get() {
  final stream = firestore.collection('rooms').snapshots();
  stream.listen((event) {
    _roomStream.add(event);
  });
  return _roomStream.map((room) => room.docs).map(_convert);
}*/