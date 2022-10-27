import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../participant/infra/models/dto/participant_dto.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../shared/configs/app_images.dart';

import '../../../shared/configs/app_routes.dart';
import '../../view-models/room_view_model.dart';

class RoomPageTwoWidget extends StatefulWidget {
  final RoomViewModel roomViewModel;

  RoomPageTwoWidget(this.roomViewModel);

  @override
  _RoomPageTwoWidgetState createState() => _RoomPageTwoWidgetState();
}

class _RoomPageTwoWidgetState extends State<RoomPageTwoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.roomViewModel.room.participants.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnimatedBuilder(
                      animation: this.widget.roomViewModel,
                      builder: (context, child) {
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
                                    widget.roomViewModel.room
                                        .participants[index].nickname,
                                    style: GoogleFonts.inter(
                                      color: AppColors.darkBrown,
                                      fontSize: 18,
                                    ))),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.privateRoomRoute,
                                  arguments: ParticipantDTO(
                                      user: widget.roomViewModel.room
                                          .participants[index]));
                            });
                      }));
            }));
  }
}
