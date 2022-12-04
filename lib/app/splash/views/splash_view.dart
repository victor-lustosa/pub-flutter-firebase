import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../../establishment/presentation/view-models/establishment_view_model.dart';
import '../../shared/configs/app_configs.dart';
import '../../shared/configs/app_routes.dart';
import '../../user/presentation/blocs/user_bloc.dart';
import '../../user/presentation/view-models/user_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final UserViewModel userViewModel;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        userViewModel = UserViewModel(
          bloc: context.read<UserBloc>(),
        );
        userViewModel.bloc.add(
          GetUserEvent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is FetchedUserState) {
            if (state.user != null) {
              context.read<EstablishmentViewModel>().user =
                  UserAdapter.user(state.user!);
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.establishmentRoute,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.homeRoute,
              );
            }
          }
        },
        bloc: context.read<UserBloc>(),
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.darkBrown,
              ),
            ),
          );
        },
      ),
    );
  }
}
