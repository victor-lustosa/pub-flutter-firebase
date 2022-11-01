import 'package:flutter/material.dart';
import '../../room/blocs/bloc_events.dart';
import '../../participant/blocs/participant_bloc.dart';
import '../../room/infra/models/message_model.dart';
import '../../user/infra/models/user_model.dart';

abstract class IParticipantViewModel {
  sendMessage(ParticipantBloc bloc);
}

class ParticipantViewModel extends ChangeNotifier
    implements IParticipantViewModel {
  ParticipantViewModel({required this.participant, required this.bloc});
  final ParticipantBloc bloc;
  final focusNode = FocusNode();
  final textController = TextEditingController(text: '');
  String error = '';
  int lineNumbers = 1;
  UserModel participant;

  sendMessage(ParticipantBloc bloc) {
    String textMessage = textController.text;

    if (textMessage.isNotEmpty) {
      /*var mes = MessageModel(
          id: '',
          createdAt: DateTime.now().toString(),
          textMessage: textMessage,
          user: this.participant,
          type: BlocEventType.send_private_message, );

      participant.messages.add(mes);

      bloc.add(SendPrivateMessageEvent(mes.toMap()));
      focusNode.requestFocus();
      textController.clear();
      focusNode.requestFocus();*/
    }
  }

  void dispose() {
    super.dispose();
    textController.dispose();
    focusNode.dispose();
  }

  typeMessage(state, index) {
    // Timer(Duration(microseconds: 50), (){
    //   this.scrollViewController.jumpTo(
    //       this.scrollViewController.position.maxScrollExtent
    //   );
    // });
    /* if (state is SendMessageState || state is ReceivePublicMessageState) {
      return Text(
          '${_participant.messages[index].getUser.getNickname} - ${_participant.messages[index].getTextMessage}');
    } else if (state is EnterPublicRoomMessageState) {
      return Center(
          child: Text('${state.message.getUser.getNickName} entrou na sala'));
    }*/
  }

  void addMessages(MessageModel message) {
    participant.messages.add(message);
  }

// reload(RoomBloc bloc) {
//   widget.bloc.add(LoadingRoomsEvent());
// }
}
