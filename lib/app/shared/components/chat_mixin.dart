import 'package:flutter/material.dart';

import '../../room/blocs/room_bloc.dart';
import '../configs/app_colors.dart';

mixin ChatMixin {
  Alignment alignment(state, index, user) {
    if (state is SendMessageState || state is ReceivePublicMessageState) {
      if (user.messages[index].user.nickname != user.nickname) {
        return Alignment.centerLeft;
      } else {
        return Alignment.centerRight;
      }
    } else {
      return Alignment.center;
    }
  }
  Color color(state, index, user) {
    if (state is SendMessageState || state is ReceivePublicMessageState) {
      if (user.messages[index].user.nickname != user.nickname) {
        return Colors.white;
      } else {
        return Color(0xffdcd9d9);
      }
    } else {
      return AppColors.lightBrown;
    }
  }
}