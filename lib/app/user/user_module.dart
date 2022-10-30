import 'package:provider/provider.dart';
import 'package:pub/app/user/domain/use-cases/user_use_cases.dart';

import 'domain/repositories/user_repository.dart';
import 'external/datasources/user_shared_datasource.dart';
import 'infra/datasources/user_datasource.dart';
import 'infra/repositories/user_repository.dart';
final userModule = [
  Provider<IUserDatasource>(create: (context) => UserSharedDatasource(shared: context.read())),
  Provider<IUserRepository>(create: (context) => UserRepository(datasource: context.read())),
  //usecases
  Provider<IUserUseCases>(create: (context) => UserUseCases(repository: context.read()))
];


