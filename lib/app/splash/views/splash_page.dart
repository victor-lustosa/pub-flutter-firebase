import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub/app/user/external/datasources/user_shared_datasource.dart';
import 'package:pub/app/user/infra/repositories/user_repository.dart';
import '../../establishment/infra/models/dto/establishment_dto.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_routes.dart';
import '../../user/blocs/user_bloc.dart';
import '../../user/domain/use-cases/user_use_cases.dart';
import '../../user/view-models/user_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final UserViewModel userViewModel;

  @override
  initState() {
    super.initState();
    userViewModel = UserViewModel(
        bloc: UserBloc(
            userUseCases: UserUseCases(
                repository: UserRepository(
                    datasource: UserSharedDatasource()))));
    userViewModel.bloc.add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is FetchedUserState) {
                userViewModel.checkUser(context, state.user);
              }
            },
            bloc: userViewModel.bloc,
            builder: (context, state) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.darkBrown)));
            }));
  }
}
