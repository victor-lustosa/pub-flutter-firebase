import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../room/view-models/room_view_model.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../room/blocs/room_bloc.dart';
import '../../../shared/configs/app_fonts.dart';

class RoomPageOneWidget extends StatefulWidget {
  @override
  State<RoomPageOneWidget> createState() => _RoomPageOneWidgetState();
}

class _RoomPageOneWidgetState extends State<RoomPageOneWidget> {
  //String userSendMessage = '';
  //bool isAddPositionNameMessage = false;
  //int nameMessageCount = 0;
  double offset = 0.0;

  @override
  initState() {
    super.initState();
    context.read<RoomViewModel>().scrollViewController =
        ScrollController(initialScrollOffset: 0.0);
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
                  return Expanded(child: Container());
                } else if (state is EnterRoomState) {
                  return Expanded(child: Container());
                } else if (state is LeaveRoomState) {
                 print("VASCO SOBE");
                  return Expanded(child: Container(child: Text("VASCO SOBE")));
                } else {
                  return Expanded(
                      child: ListView.builder(
                          key: PageStorageKey<String>('MessagesList'),
                          controller: context.read<RoomViewModel>().scrollViewController,
                          itemCount: context.read<RoomViewModel>().messages.length,
                          itemBuilder: (context, index) {

                            context.read<RoomViewModel>().scroll();

                            return Align(
                                alignment: context.read<RoomViewModel>().messages[index].user.nickname != context.read<RoomViewModel>().user.nickname
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Stack(fit: StackFit.loose,
                                        // alignment: AlignmentDirectional.centerStart,
                                        // width: MediaQuery.of(context).size.width * 0.8,
                                        children: [
                                          Column(
                                              crossAxisAlignment: context.read<RoomViewModel>().messages[index].user.nickname != context.read<RoomViewModel>().user.nickname
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.end,
                                              children: [
                                                // context.read<RoomViewModel>().messages[index].namePosition < 2?
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 6, left: 6),
                                                    child: Row(
                                                        children: [
                                                          Text(
                                                          '${context.read<RoomViewModel>().messages[index].user.nickname}'),
                                                    ])),
                                                Container(
                                                    // width: MediaQuery.of(context).size.width * 0.8,
                                                    padding: const EdgeInsets.all(14),
                                                    decoration: BoxDecoration(
                                                        color: context.read<RoomViewModel>().messages[index].user.nickname != context.read<RoomViewModel>().user.nickname
                                                            ? Colors.white
                                                            : Color(0xffdcd9d9),
                                                        border: Border.all(color: Color(0xffdcd9d9), width: 1),
                                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                                    child: Text('${context.read<RoomViewModel>().messages[index].textMessage}'))
                                                //     : Padding(
                                                //     padding: const EdgeInsets.only(bottom: 0)
                                                // )
                                              ]),
                                        ])));
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
                        context.read<RoomViewModel>().sendMessage('');
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
                          context.read<RoomViewModel>().sendMessage('public');
                        }),
                  ),
                ),
              ]))
        ]));
  }
}
