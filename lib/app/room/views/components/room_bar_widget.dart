import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/configs/app_colors.dart';

import '../../view-models/room_view_model.dart';

class RoomBarWidget extends StatefulWidget {
  RoomBarWidget(this.roomViewModel);

  final RoomViewModel roomViewModel;

  @override
  State<RoomBarWidget> createState() => _RoomBarWidgetState();
}

class _RoomBarWidgetState extends State<RoomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.navigate_before_rounded,
                        color: AppColors.darkBrown,
                      ),
                      color: AppColors.darkBrown,
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // CircleAvatar(
              //     maxRadius: 20,
              //     backgroundColor: Colors.grey,
              //     backgroundImage: widget.contato.urlImagem != null
              //         ? NetworkImage(widget.contato.urlImagem)
              //         : null),

              Padding(
                  padding: EdgeInsets.only(left: 48),
                  child: Text(
                    widget.roomViewModel.room.name,
                    style: GoogleFonts.inter(
                        fontSize: 17, color: AppColors.darkBrown),
                  ))
            ],
          ),
        ]);
  }
}
