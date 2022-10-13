import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub/app/establishment/blocs/establishment_bloc.dart';
import 'package:pub/app/establishment/view-models/establishment_view_model.dart';
import 'package:pub/app/participant/view-models/participant_view_model.dart';

import '../../../core/configs/app_colors.dart';
import '../../../core/configs/app_images.dart';
import '../../../core/configs/app_routes.dart';

import '../../../room/models/dto/room_dto.dart';
import '../../../room/view-models/room_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/use-cases/get_establishments.dart';

class EstablishmentPageOneWidget extends StatefulWidget {
 /* EstablishmentPageOneWidget(
      this._establishmentViewModel, this.participantViewModel, this.bloc);
  final EstablishmentBloc bloc;
  final EstablishmentViewModel _establishmentViewModel;
  final ParticipantViewModel participantViewModel;*/
  EstablishmentPageOneWidget();
  @override
  State<EstablishmentPageOneWidget> createState() =>
      _EstablishmentPageOneWidgetState();
}

class _EstablishmentPageOneWidgetState
    extends State<EstablishmentPageOneWidget> {

  late final EstablishmentBloc bloc;
  late final RoomViewModel _roomViewModel;
  late final EstablishmentViewModel _establishmentViewModel;
  late final ParticipantViewModel participantViewModel;
  late StreamSubscription mSub;
  @override
  initState() {

   // final IGetEstablishments _getEstablishments = GetEstablishments();
    //bloc = EstablishmentBloc(getEstablishmentsUseCase: null);
    /*mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });*/
    super.initState();
  }

  @override
  didChangeDependencies() {
    /* mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });*/
    super.didChangeDependencies();
  }

  @override
  dispose() {
    mSub.cancel();
    super.dispose();
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
          child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
              bloc: bloc,
              buildWhen: (context, current) =>
                  context.runtimeType != current.runtimeType &&
                  (
                      current is SuccessRoomsState ||
                      current is LoadingRoomsState ),
              builder: (context, state) {
                if (state is InitialState) {
                  return Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.only(top: 270),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.darkBrown))))
                        ])
                      ]);
                } else if (state is LoadingRoomsState ) {
                  return Container(child:Center(child:CircularProgressIndicator()));
                }
                else if (state is SuccessRoomsState ) {
                  return RefreshIndicator(
                      color: AppColors.darkBrown,
                      onRefresh: () async {
                        bloc.add(GetEstablishmentsEvent());
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: this._establishmentViewModel.getRooms.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: AnimatedBuilder(
                                    animation: this._roomViewModel,
                                    builder: (context, child) {
                                      return ListTile(
                                          leading: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25, bottom: 10),
                                              child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey.withOpacity(0.15),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset: Offset(1, 3)),
                                                      ]),
                                                  child: this._establishmentViewModel.isAcceptedLocation(
                                                      this._establishmentViewModel.getRooms[index])
                                                      ? Image.asset(
                                                          AppImages.lightLogo,
                                                          width: 20,
                                                          height: 20)
                                                      : Image.asset(
                                                          AppImages.lightUnauthorizedLogo,
                                                          width: 20,
                                                          height: 20))),
                                          title: Padding(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: this._establishmentViewModel.isAcceptedLocation(
                                                  this._establishmentViewModel.getRooms[index])
                                                  ? Text(this._establishmentViewModel.getRooms[index].getRoomName,
                                                      style: GoogleFonts.inter(
                                                        color: AppColors.brown,
                                                        fontSize: 18,
                                                      ))
                                                  : Text(this._establishmentViewModel.getRooms[index].getRoomName,
                                                      style: GoogleFonts.inter(
                                                        color: Colors.grey,
                                                        fontSize: 18,
                                                      ))),
                                          subtitle: Row(
                                            children: [
                                              this._establishmentViewModel.getRooms[index].getParticipants.length == 1
                                                  ? Text('${this._establishmentViewModel.getRooms[index].getParticipants.length} pessoa',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13,
                                                          color: Colors.black45))
                                                  : Text('${this._establishmentViewModel.getRooms[index].getParticipants.length} pessoas',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13,
                                                          color: Colors.black45)),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 40),
                                                  child: Text('${(this._establishmentViewModel.getRooms[index].getDistance).toStringAsFixed(2)} km de distância',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13,
                                                          color: Colors.black45)))
                                            ],
                                          ),
                                          onTap: () {
                                            if (this._establishmentViewModel.isAcceptedLocation(this._establishmentViewModel.getRooms[index])) {
                                              bool isUserExist = _establishmentViewModel.verifyNameUser(this._establishmentViewModel.getRooms[index]);
                                              if (!isUserExist) {
                                               // this._establishmentViewModel.setRoom(this._establishmentViewModel.getRooms[index]);
                                                /*Navigator.pushNamed(context,
                                                    AppRoutes.publicRoomRoute,
                                                    arguments: RoomDTO(
                                                        bloc: bloc,
                                                        roomViewModel: this._establishmentViewModel,
                                                        participantViewModel: this.participantViewModel));*/
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(content: Text('Seu nickname já existe na sala, altere-o para entrar')));
                                              }
                                            }
                                          });
                                    }));
                          }));
                } else {
                  return Text('aconteceu um erro [Establishment_page_one]');
                }
              })),
    );
  }
}
