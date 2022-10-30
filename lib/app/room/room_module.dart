import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pub/app/room/domain/use-cases/room_use_cases.dart';
import '../../app/room/external/room_firestore_datasource.dart';

import '../room/infra/repositories/room_repository.dart';
import 'blocs/room_bloc.dart';
import 'domain/repositories/room_repository.dart';
import 'infra/datasources/room_datasource.dart';

final roomModule = [
  Provider<FirebaseFirestore>.value(value: FirebaseFirestore.instance),
  Provider<IRoomDatasource>(create: (context) => RoomFirestoreDatasource(firestore: context.read())),
  Provider<IRoomRepository>(create: (context) => RoomRepository(datasource: context.read())),
  //usecases
  Provider<IRoomUseCases>(create: (context) => RoomUseCases(repository: context.read())),
  Provider<RoomBloc>(create: (context) => RoomBloc(roomUseCases: context.read()))
];
