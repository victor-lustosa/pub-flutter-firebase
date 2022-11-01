import 'package:flutter/material.dart';

import '../../../shared/configs/app_colors.dart';
// import '../../repositories/establishment_repository_dto.dart';
// import '../../view-models/establishment_view_model.dart';

class ParticipantsChatsWidget extends StatelessWidget {
  ParticipantsChatsWidget();

  // EstablishmentViewModel _establishmentViewModel = EstablishmentViewModel(DioEstablishmentRepository(Dio()));
  // late List<dynamic> _establishments;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      decoration: BoxDecoration(color: AppColors.darkBrown),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// import '../../../../shared/configs/app_colors.dart';
// import '../../../../shared/configs/app_images.dart';
// import '../../../../shared/configs/app_routes.dart';
// import '../../../../shared/room_bloc/stablishment_bloc.dart';
// import '../../../participant/view-models/participant_view_model.dart';
// import '../../../room/view-models/room_view_model.dart';
// // import '../../repositories/establishment_repository_dto.dart';
// // import '../../view-models/establishment_view_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class EstablishmentPageTwoWidget extends StatefulWidget {
//
//   EstablishmentPageTwoWidget(this.roomViewModel, this.participantViewModel, this.bloc);
//   final RoomViewModel roomViewModel;
//   final ParticipantViewModel participantViewModel;
//   final RoomBloc bloc;
//   // EstablishmentViewModel _establishmentViewModel = EstablishmentViewModel(DioEstablishmentRepository(Dio()));
//   // late List<dynamic> _establishments;
//
//   @override
//   State<EstablishmentPageTwoWidget> createState() => _EstablishmentPageTwoWidgetState();
// }
//
// class _EstablishmentPageTwoWidgetState extends State<EstablishmentPageTwoWidget> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: AppColors.white,
//         ),
//         child:BlocBuilder<RoomBloc,RoomState>(
//             bloc: widget.bloc,
//             buildWhen: (context, current) => context.runtimeType != current.runtimeType &&
//                 (current is InitialState ||
//                     current is SuccessRoomsState ||
//                     current is DisconnectState ||
//                     current is EnterPublicRoomMessageState ||
//                     current is LeavePublicRoomMessageState
//                 ),
//             builder:(context, state) {
//               if(state is InitialState) {
//                 return Stack(
//                     fit: StackFit.loose,
//                     alignment: Alignment.center,
//                     children: [
//                       Column( children: [
//                         Padding(
//                             padding: EdgeInsets.only(top: 270),
//                             child: Center(
//                                 child: CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkBrown))
//                             ))
//                       ])
//                     ]);
//               } else if(state is SuccessRoomsState ||
//                   state is EnterPublicRoomMessageState ||
//                   state is DisconnectState||
//                   state is LeavePublicRoomMessageState) {
//                 return ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: widget.roomViewModel.getRoom.getParticipants.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                           padding: const EdgeInsets.only(bottom: 12.0),
//                           child: AnimatedBuilder(
//                               animation: this.widget.roomViewModel,
//                               builder: (context, child) {
//                                 return ListTile(
//                                     leading: Padding(
//                                         padding: EdgeInsets.only(left: 25, bottom: 10),
//                                         child: Container(
//                                           width: 40,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                             color: AppColors.white,
//                                             borderRadius: BorderRadius.all(const Radius.circular(5.0)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey.withOpacity(0.15),
//                                                 spreadRadius: 1,
//                                                 blurRadius: 3,
//                                                 offset: Offset(1, 3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Image.asset(
//                                               AppImages.userAvatar, width: 20,
//                                               height: 20),)),
//                                     title: Padding(
//                                         padding: EdgeInsets.only(bottom: 10),
//                                         child: Text(widget.roomViewModel.getRoom.getParticipants[index].getNickname,
//                                             style: AppFonts.participantNicknamePageTwo)
//                                     ),
//                                     // subtitle:Row(
//                                     //   children: [
//                                     //     Text( 'pessoas',
//                                     //         style:AppFonts.distanceLabelPageTwo),
//                                     //     Padding(
//                                     //         padding: EdgeInsets.only(left: 40) ,
//                                     //         child: Text('3.2 km de distância',
//                                     //             style:)
//                                     //     ),
//                                     //   ],
//                                     // ),
//                                     onTap: () {
//                                       // widget.participantViewModel.setParticipant(widget.roomViewModel.getRoom.getParticipants[index]);
//                                       // Navigator.pushNamed(context, AppRoutes.PRIVATE_ROOM_ROUTE,arguments:
//                                       // ParticipantDTO(
//                                       //     bloc: widget.bloc,
//                                       //     participantViewModel: this.widget.participantViewModel));
//                                     }
//                                 );
//                               }
//                           ));
//                     });} else{
//                 return Text('aconteceu um erro [Establishment_page_one]');
//               }
//             }
//         ));
//   }
// }
