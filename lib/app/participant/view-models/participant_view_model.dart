import 'package:flutter/material.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/infra/models/user_model.dart';
import '../../room/blocs/room_bloc.dart';
import '../../room/blocs/bloc_events.dart';
import '../../room/infra/models/data/message_data.dart';

abstract class IParticipantViewModel {
  sendMessage(RoomBloc bloc);
}

class ParticipantViewModel extends ChangeNotifier
    implements IParticipantViewModel {
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  int lineNumbers = 1;
  late UserModel _participant;

  sendMessage(RoomBloc bloc) {
    String textMessage = textController.text;

    if (textMessage.isNotEmpty) {
      var mes = MessageData(
          idRoom: '',
          createdAt: DateTime.now().toString(),
          roomName: '',
          idMessage: '',
          textMessage: textMessage,
          user: this.getParticipant,
          code: 0,
          type: BlocEventType.send_private_message);

      _participant.messages.add(mes);

      bloc.add(SendPrivateMessageEvent(mes.toMap()));
      focusNode.requestFocus();
      textController.clear();
      focusNode.requestFocus();
    }
  }

  void dispose() {
    super.dispose();
    textController.dispose();
    focusNode.dispose();
  }

  Alignment alignment(state, index) {
    if (state is SendMessageState || state is ReceivePublicMessageState) {
      if (_participant.messages[index].user.nickname != _participant.nickname) {
        return Alignment.centerLeft;
      } else {
        return Alignment.centerRight;
      }
    } else {
      return Alignment.center;
    }
  }

  Color color(state, index) {
    if (state is SendMessageState || state is ReceivePublicMessageState) {
      if (_participant.messages[index].user.nickname != _participant.nickname) {
        return Colors.white;
      } else {
        return Color(0xffdcd9d9);
      }
    } else {
      return AppColors.lightBrown;
    }
  }

  typeMessage(state, index) {
    // Timer(Duration(microseconds: 50), (){
    //   this.scrollViewController.jumpTo(
    //       this.scrollViewController.position.maxScrollExtent
    //   );
    // });
    if (state is SendMessageState || state is ReceivePublicMessageState) {
      return Text(
          '${_participant.messages[index].user.nickname} - ${_participant.messages[index].textMessage}');
    } else if (state is EnterPublicRoomMessageState) {
      return Center(
          child: Text('nome entrou na sala'));
    }
  }

  get getParticipant => _participant;

  setParticipant(UserModel participant) => _participant = participant;

  void addMessages(MessageData message) {
    getParticipant.addMessages(message);
  }

  // reload(RoomBloc bloc) {
  //   widget.bloc.add(LoadingRoomsEvent());
  // }
}
