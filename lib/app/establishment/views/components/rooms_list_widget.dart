import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../room/view-models/room_view_model.dart';
import '../../../shared/configs/app_fonts.dart';
import '../../../shared/components/location_util.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../shared/configs/app_images.dart';
import '../../../shared/configs/app_routes.dart';
import '../../blocs/establishment_bloc.dart';
import '../../view-models/establishment_view_model.dart';

class RoomsListWidget extends StatelessWidget {
  const RoomsListWidget({super.key});

  //late StreamSubscription mSub;

  /*mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBrown,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
          bloc: context.read<EstablishmentBloc>(),
          buildWhen: (context, current) => (current is SuccessfullyFetchedRoomsState),
          builder: (context, state) {
            if (state is SuccessfullyFetchedRoomsState) {
              context.read<EstablishmentViewModel>().rooms =
                  LocationUtil.calculateDistance(
                    state.entities,
                    context.read<EstablishmentViewModel>().user,
                  );

              return RefreshIndicator(
                color: AppColors.darkBrown,
                onRefresh: () async {
                  context.read<EstablishmentViewModel>().bloc.add(
                        GetRoomsEvent(),
                      );
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:
                     context.read<EstablishmentViewModel>().rooms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AnimatedBuilder(
                        animation: context.read<EstablishmentViewModel>(),
                        builder: (context, child) {
                          return ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                bottom: 10,
                              ),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(1, 3),
                                      ),
                                    ],
                                ),
                                child: context.read<EstablishmentViewModel>()
                                              .rooms[index]
                                              .isAcceptedLocation
                                    ? Image.asset(AppImages.lightLogo,
                                        width: 20, height: 20)
                                    : Image.asset(
                                        AppImages.lightUnauthorizedLogo,
                                        width: 20,
                                        height: 20,
                                      ),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                context.read<EstablishmentViewModel>()
                                       .rooms[index]
                                       .name,
                                style: context.read<EstablishmentViewModel>()
                                              .rooms[index]
                                              .isAcceptedLocation
                                    ? AppFonts.roomEnabledName
                                    : AppFonts.roomDisabledName,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  context.read<EstablishmentViewModel>()
                                         .rooms[index]
                                         .participants
                                         .length == 1
                                      ? '${context.read<EstablishmentViewModel>().rooms[index].participants.length} pessoa'
                                      : '${context.read<EstablishmentViewModel>().rooms[index].participants.length} pessoas',
                                  style: AppFonts.numberParticipants,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Text(
                                    '${(context.read<EstablishmentViewModel>().rooms[index].distance).toStringAsFixed(2)} km de distância',
                                    style: AppFonts.distanceLabel,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (!context.read<EstablishmentViewModel>().verifyNameUser(
                                    context.read<EstablishmentViewModel>().rooms[index],
                                  )) {
                                context.read<RoomViewModel>().user = context.read<EstablishmentViewModel>().user;
                                context.read<RoomViewModel>().room = context.read<EstablishmentViewModel>().room;
                                Navigator.pushNamed(
                                    context, AppRoutes.publicRoomRoute,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Seu nickname já existe na sala, altere-o para entrar'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return RefreshIndicator(
                color: AppColors.darkBrown,
                onRefresh: () async {
                  context.read<EstablishmentViewModel>().bloc.add(
                        GetRoomsEvent(),
                      );
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.darkBrown),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
