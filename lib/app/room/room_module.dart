import 'external/room_firestore_datasource.dart';
import 'presentation/blocs/room_bloc.dart';
import 'domain/use-cases/room_use_cases.dart';
import 'infra/repositories/room_repository.dart';
import 'presentation/view-models/room_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final roomModule = [
  Provider<RoomBloc>(
    create: (context) => RoomBloc(
      roomUseCases: RoomUseCases(
        repository: RoomRepository(
          datasource: RoomFirestoreDatasource(
            firestore: FirebaseFirestore.instance,
          ),
        ),
      ),
    ),
  ),
  Provider<RoomViewModel>(
    create: (context) => RoomViewModel(
      bloc: context.read(),
    ),
  ),
];
