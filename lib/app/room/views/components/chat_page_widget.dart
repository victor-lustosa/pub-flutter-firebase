import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../../../room/view-models/room_view_model.dart';
import '../../../shared/components/chat_mixin.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../room/blocs/room_bloc.dart';
import '../../../shared/configs/app_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> with ChatMixin {
  //String userSendMessage = '';
  final double offset = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(),
      () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
    );
    /* LocationUtil.verifyLocation(context,
        widget.bloc,
        widget.mSub,
        widget.instance.getRoom,
        widget.instance.getUser);*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          BlocBuilder<RoomBloc, RoomState>(
              bloc: context.read<RoomBloc>(),
              builder: (context, state) {
                if (state is InitialState) {
                  return Expanded(
                      child: Container());
                } else if (state is EnterRoomState) {
                  return Expanded(
                      child: Container());
                } else if (state is LeaveRoomState) {
                  return Expanded(
                      child: Container());
                } else {
                  if (state is SuccessfullyFetchedRoomsState)
                    context.read<RoomViewModel>().fetchedMessagesList(state.rooms);

                  return Expanded(
                      child: ListView.builder(
                          key: PageStorageKey<String>('MessagesList'),
                          controller: context.read<RoomViewModel>().scrollViewController,
                          itemCount: context.read<RoomViewModel>().messages.length,
                          itemBuilder: (context, index) {
                            bool x = false;
                            return Row(
                                mainAxisAlignment: crossAlignment(
                                    context.read<RoomViewModel>().messages[index],
                                    context.read<RoomViewModel>().user),
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        //TODO: essa linha posiciona o nome, entao precisa colocar CrossAxisAlignment.start pro
                                        //TODO: usuario esquerdo e CrossAxisAlignment.end pro direito
                                        //TODO: proximo passo: nao repetir o nome nas mensagens de mesmo usuario
                                        //TODO: deixar o tamanho do box dinamico com tanto de mensagem ate o limite de media * 0.8
                                        //TODO: talvez um boolean dentro da mensagem dizendo que o titulo é visivel ou nao seja uma alternativa
                                        //TODO: ou uma condicional na tela que verifica qual usuario ta sendo imprimido
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         // if(x == true) ...[] condiciona somente um widget em particular
                                          Visibility(
                                            visible: true,
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Text('${context.read<RoomViewModel>().messages[index].user.nickname}')),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                  color: colorMessage(
                                                      context.read<RoomViewModel>().messages[index],
                                                      context.read<RoomViewModel>().user),
                                                  border: Border.all(
                                                      color: Color(0xffdcd9d9),
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                                              child: Text('${context.read<RoomViewModel>().messages[index].textMessage}')),
                                        ],
                                      )),
                                ]);
                          }));
                }
              }),
          SafeArea(
              top: false,
              child: Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4, right: 8),
                    child: TextField(
                      onEditingComplete: () {},
                      focusNode: context.read<RoomViewModel>().focusNode,
                      onSubmitted: (_) {
                        context.read<RoomViewModel>().sendMessage();
                      },
                      controller: context.read<RoomViewModel>().textController,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: context.read<RoomViewModel>().lineNumbers,
                      style: AppFonts.boxMessage,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                          hintText: "Digite uma mensagem...",
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: FloatingActionButton(
                        backgroundColor: AppColors.brown,
                        child: Icon(
                          Icons.near_me_outlined,
                          size: 29,
                          color: Colors.white,
                        ),
                        mini: true,
                        onPressed: () {
                          context.read<RoomViewModel>().sendMessage();
                          context.read<RoomViewModel>().scroll();
                        }),
                  ),
                ),
              ]))
        ]));
  }
}
