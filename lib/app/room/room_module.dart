import 'external/room_firestore_datasource.dart';
import 'blocs/room_bloc.dart';
import 'domain/use-cases/room_use_cases.dart';
import 'infra/repositories/room_repository.dart';
import 'view-models/room_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final roomModule = [
  Provider<RoomBloc>(
    create: (context) => RoomBloc(
      roomUseCases: RoomUseCases(
        repository: RoomRepository(
          datasource:
              RoomFirestoreDatasource(firestore: FirebaseFirestore.instance),
        ),
      ),
    ),
  ),
  ChangeNotifierProvider<RoomViewModel>(
    create: (context) => RoomViewModel(
      bloc: context.read(),
    ),
  ),
];
