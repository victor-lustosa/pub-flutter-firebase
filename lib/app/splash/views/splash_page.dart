import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub/app/user/infra/adapters/user_adapter.dart';
import '../../establishment/view-models/establishment_view_model.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_routes.dart';
import '../../user/blocs/user_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userViewModel = UserViewModel(bloc: context.read<UserBloc>());
      userViewModel.bloc.add(GetUserEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is FetchedUserState) {
                if (state.user != null) {
                  context.read<EstablishmentViewModel>().user = UserAdapter.user(state.user!);
                  Navigator.pushReplacementNamed(context, AppRoutes.establishmentRoute);
                } else {
                  Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
                }
              }
            },
            bloc: context.read<UserBloc>(),
            builder: (context, state) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkBrown)));
       }));
  }
}
