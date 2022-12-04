import 'package:flutter/material.dart';
import '../../room/domain/entities/message_entity.dart';
import '../../user/infra/models/user_model.dart';
import '../configs/app_configs.dart';

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
  colorMessage(MessageEntity message, UserModel user){
    Color color;
    if (message.type.name != 'notification_message' &&
        message.user.nickname != user.nickname) {
      color = AppColors.white;
    } else if (message.type.name != 'notification_message' &&
        message.user.nickname == user.nickname) {
      color = AppColors.grey;
    } else{
      color = AppColors.lightBrown;
    }
    return color;
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
