import 'dart:async';
import '../infra/datasources/establishment_datasource.dart';

class EstablishmentFunctionsDatasource implements IEstablishmentDatasource {
  // final Dio dio;

  //RoomFunctionsDatasource(this.dio);

  // List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  //   return;'
  //}

  @override
  Stream<List<Map>> get() {
    //   final valorRetornado = dio.get('url/exemplo');
    StreamController<List<Map>> exemplo = StreamController<List<Map>>();

    return exemplo.stream;
  }

  @override
  entityStream() {
    // TODO: implement entityStream
    throw UnimplementedError();
  }
}
