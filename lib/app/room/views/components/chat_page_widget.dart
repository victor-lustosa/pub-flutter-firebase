import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../room/view-models/room_view_model.dart';
import '../../../shared/components/chat_mixin.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../room/blocs/room_bloc.dart';
import '../../../shared/configs/app_fonts.dart';

class ChatPageWidget extends StatelessWidget with ChatMixin{


  //String userSendMessage = '';
  //bool isAddPositionNameMessage = false;
  //int nameMessageCount = 0;
 final double offset = 0.0;


    /* LocationUtil.verifyLocation(context,
        widget.bloc,
        widget.mSub,
        widget.instance.getRoom,
        widget.instance.getUser);*/

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
                  return Expanded(child: Container());
                } else if (state is EnterRoomState) {
                  return Expanded(child: Container());
                } else if (state is LeaveRoomState) {
                  return Expanded(child: Container());
                } else {
                  if(state is SuccessfullyFetchedRoomsState)
                    context.read<RoomViewModel>().fetchedMessagesList(state.rooms);

                  return Expanded(
                    child: ListView.builder(
                      key: PageStorageKey<String>('MessagesList'),
                      controller: context.read<RoomViewModel>().scrollViewController,
                      itemCount: context.read<RoomViewModel>().messages.length,
                      itemBuilder: (context, index) {
                        context.read<RoomViewModel>().scroll();

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Stack(
                            children: [
                              Row( mainAxisAlignment: crossAlignment(
                                  context.read<RoomViewModel>().messages[index],
                                  context.read<RoomViewModel>().user),
                                children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:0),
                                  child: Text('${context.read<RoomViewModel>().messages[index].user.nickname}'),
                                ),
                              ],),
                              Row(
                                  mainAxisAlignment: crossAlignment(
                                      context.read<RoomViewModel>().messages[index],
                                      context.read<RoomViewModel>().user),
                                  children: [

                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        child:messageComponent(context.read<RoomViewModel>().messages[index],
                                            context.read<RoomViewModel>().user,context)),
                                    ]),
                            ],
                          ));
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
                        }),
                  ),
                ),
              ]))
        ]));
  }
}
