import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/configs/app_fonts.dart';
import '../../../participant/infra/models/dto/participant_dto.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../shared/configs/app_images.dart';

import '../../../shared/configs/app_routes.dart';
import '../../view-models/room_view_model.dart';

class ParticipantsListWidget extends StatelessWidget {
  const ParticipantsListWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child:  AnimatedBuilder(
        animation: context.read<RoomViewModel>(),
    builder: (context, child) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: context.read<RoomViewModel>().participants.length,
              itemBuilder: (context, index) {

                return ListTile(
                    leading: Padding(
                        padding: EdgeInsets.only(left: 25, bottom: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                                const Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(
                                    1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Image.asset(AppImages.userAvatar,
                              width: 20, height: 20),
                        )),
                    title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                            context.read<RoomViewModel>().room
                                .participants[index].nickname,
                            style: AppFonts.roomNickname)),
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.privateRoomRoute,
                          arguments: ParticipantDTO(
                              user: context.read<RoomViewModel>().room
                                  .participants[index]));

                              });
                        });
              }),
        );
  }
}
