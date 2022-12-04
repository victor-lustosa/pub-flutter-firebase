
import '../user/presentation/view-models/user_view_model.dart';

import 'presentation/blocs/user_bloc.dart';
import 'domain/use-cases/user_use_cases.dart';
import 'infra/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class Instance {
  static dynamic userFlow(userSharedDatasource) {
    final userModule = [
      Provider<UserBloc>(
        create: (context) => UserBloc(
          userUseCases: UserUseCases(
            repository: UserRepository(
              datasource: userSharedDatasource,
            ),
          ),
        ),
      ),
      ChangeNotifierProvider<UserViewModel>(
        create: (context) => UserViewModel(
          bloc: context.read(),
        ),
      ),
    ];
    return userModule;
  }
}
