import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/configs/app_colors.dart';

import '../../../room/blocs/room_bloc.dart';
import '../../view-models/room_view_model.dart';

class RoomBarWidget extends StatefulWidget {
  RoomBarWidget(this.bloc, this.roomViewModel);

  final RoomBloc bloc;
  final RoomViewModel roomViewModel;
  @override
  State<RoomBarWidget> createState() => _RoomBarWidgetState();
}

class _RoomBarWidgetState extends State<RoomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // CircleAvatar(
        //     maxRadius: 20,
        //     backgroundColor: Colors.grey,
        //     backgroundImage: widget.contato.urlImagem != null
        //         ? NetworkImage(widget.contato.urlImagem)
        //         : null),

        Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              widget.roomViewModel.getRoom.name,
              style:
                  GoogleFonts.inter(fontSize: 17, color: AppColors.darkBrown),
            ))
      ],
    );
  }
}
