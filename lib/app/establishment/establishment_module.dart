import 'view-models/establishment_view_model.dart';
import 'blocs/establishment_bloc.dart';
import 'external/establishment_firestore_datasource.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'domain/use-cases/establishment_use_cases.dart';
import 'infra/repositories/establishment_repository.dart';

final establishmentModule = [
  Provider<EstablishmentBloc>(
    create: (context) => EstablishmentBloc(
      roomUseCases: EstablishmentUseCases(
        repository: EstablishmentRepository(
          datasource: EstablishmentFirestoreDatasource(
              firestore: FirebaseFirestore.instance),
        ),
      ),
    ),
  ),
  ChangeNotifierProvider<EstablishmentViewModel>(
    create: (context) => EstablishmentViewModel(
      bloc: context.read(),
    ),
  ),
];
