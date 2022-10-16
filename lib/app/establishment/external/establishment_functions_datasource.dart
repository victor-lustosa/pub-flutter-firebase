import 'dart:async';

import '../infra/datasources/establishment_datasource.dart';

class EstablishmentFunctionsDatasource implements IEstablishmentDatasource {
  // final Dio dio;

  //EstablishmentFunctionsDatasource(this.dio);

  // List<Map> _convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  //   return;'
  //}

  @override
  Stream<List<Map>> getEstablishments() {
    //   final valorRetornado = dio.get('url/exemplo');
    StreamController<List<Map>> exemplo = StreamController<List<Map>>();

    return exemplo.stream;
  }
}
