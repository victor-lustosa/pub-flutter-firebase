import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/configs/app_fonts.dart';
import '../../../room/blocs/room_bloc.dart';
import '../../../shared/components/location_util.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../shared/configs/app_images.dart';
import '../../../room/view-models/room_view_model.dart';
import '../../../shared/configs/app_routes.dart';

class EstablishmentPageOneWidget extends StatefulWidget {
  EstablishmentPageOneWidget();

  @override
  State<EstablishmentPageOneWidget> createState() =>
      _EstablishmentPageOneWidgetState();
}

class _EstablishmentPageOneWidgetState
    extends State<EstablishmentPageOneWidget> {
  //late StreamSubscription mSub;
  @override
  initState() {
    /*mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.darkBrown),
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: BlocBuilder<RoomBloc, RoomState>(
              bloc: context.read<RoomBloc>(),
              buildWhen: (context, current) => context.runtimeType != current.runtimeType && (current is SuccessfullyFetchedRoomsState),
              builder: (context, state) {

                if (state is SuccessfullyFetchedRoomsState) {

                  context.read<RoomViewModel>().rooms = LocationUtil.calculateDistance(state.entities, context.read<RoomViewModel>().user);

                  return RefreshIndicator(
                      color: AppColors.darkBrown,
                      onRefresh: () async {
                        context.read<RoomViewModel>().bloc.add(GetRoomsEvent());
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: context.read<RoomViewModel>().rooms.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: AnimatedBuilder(
                                    animation: context.read<RoomViewModel>(),
                                    builder: (context, child) {
                                      return ListTile(
                                          leading: Padding(
                                              padding: EdgeInsets.only(left: 25, bottom: 10),
                                              child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                                                      boxShadow: [
                                                        BoxShadow(color: Colors.grey.withOpacity(0.15),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset: Offset(1, 3)),
                                                      ]),
                                                  child: context.read<RoomViewModel>().rooms[index].isAcceptedLocation
                                                      ? Image.asset(
                                                          AppImages.lightLogo,
                                                          width: 20,
                                                          height: 20)
                                                      : Image.asset(
                                                          AppImages.lightUnauthorizedLogo,
                                                          width: 20,
                                                          height: 20)
                                              )
                                          ),
                                          title: Padding(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: Text(context.read<RoomViewModel>().rooms[index].name,
                                                  style: context.read<RoomViewModel>().rooms[index].isAcceptedLocation
                                                      ? AppFonts.roomEnabledName
                                                      : AppFonts.roomDisabledName)),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                  context.read<RoomViewModel>().participants.length == 1
                                                      ? '${context.read<RoomViewModel>().participants.length} pessoa'
                                                      : '${context.read<RoomViewModel>().participants.length} pessoas',
                                                  style: AppFonts
                                                      .numberParticipants),
                                              Padding(
                                                  padding: EdgeInsets.only(left: 40),
                                                  child: Text('${(context.read<RoomViewModel>().rooms[index].distance).toStringAsFixed(2)} km de distância',
                                                      style: AppFonts.distanceLabel))
                                            ],
                                          ),
                                          onTap: () {
                                              if (!context.read<RoomViewModel>().verifyNameUser(context.read<RoomViewModel>().rooms[index])) {
                                                Navigator.pushNamed(context, AppRoutes.publicRoomRoute);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                       const SnackBar(
                                                           content: Text('Seu nickname já existe na sala, altere-o para entrar')));
                                              }
                                          });
                                    }));
                          }));
                } else {
                  return RefreshIndicator(
                      color: AppColors.darkBrown,
                      onRefresh: () async {
                        context.read<RoomViewModel>().bloc.add(GetRoomsEvent());
                      },
                      child: Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.darkBrown))
                      ));
          }})),
    );
  }
}
