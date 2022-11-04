import 'package:flutter/material.dart';
import '../../room/domain/entities/message_entity.dart';
import '../../user/infra/models/user_model.dart';
import '../configs/app_colors.dart';

mixin ChatMixin {
  MainAxisAlignment crossAlignment(MessageEntity message, UserModel user) {
    if (message.type.name != 'notification_message' &&
        message.user.nickname != user.nickname) {
      return MainAxisAlignment.start;
    } else if (message.type.name != 'notification_message' &&
        message.user.nickname == user.nickname) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.center;
    }
  }
  messageComponent(MessageEntity message, UserModel user, context){
    if (message.type.name != 'notification_message' &&
        message.user.nickname != user.nickname) {
      return Container(
         width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xffdcd9d9), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text('${message.textMessage}'));
    } else if (message.type.name != 'notification_message' &&
        message.user.nickname == user.nickname) {
      return Container(
         width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Color(0xffdcd9d9),
              border: Border.all(color: Color(0xffdcd9d9), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text('${message.textMessage}'));
    } else{
      return Container(
         width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.lightBrown,
              border: Border.all(color: Color(0xffdcd9d9), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text('${message.textMessage}'));
    }
  }
  Alignment alignment(MessageEntity message, UserModel user) {
    if (message.type.name != 'notification_message' &&
        message.user.nickname != user.nickname) {
      return Alignment.centerLeft;
    } else if (message.type.name != 'notification_message' &&
        message.user.nickname == user.nickname) {
      return Alignment.centerRight;
    } else {
      return Alignment.center;
    }
  }
}
