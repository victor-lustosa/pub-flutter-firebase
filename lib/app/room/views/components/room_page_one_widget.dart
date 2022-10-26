import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../room/view-models/room_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/components/location_util.dart';
import '../../../shared/configs/app_colors.dart';
import '../../../room/blocs/room_bloc.dart';
import '../../blocs/bloc_events.dart';

class RoomPageOneWidget extends StatefulWidget {
  RoomPageOneWidget(this.instance, this.mSub);

  final StreamSubscription mSub;
  final RoomViewModel instance;

  @override
  State<RoomPageOneWidget> createState() => _RoomPageOneWidgetState();
}

class _RoomPageOneWidgetState extends State<RoomPageOneWidget>{
  String userSendMessage = '';
  bool isAddPositionNameMessage = false;
  int nameMessageCount = 0;
  late ScrollController scrollViewController;
  double offset = 0.0;
  @override
  initState() {
    super.initState();
    scrollViewController = ScrollController(initialScrollOffset: 0.0);
   /* LocationUtil.verifyLocation(context,
        widget.bloc,
        widget.mSub,
        widget.instance.getRoom,
        widget.instance.getUser);*/
  }

  scroll() {
    Timer(Duration(microseconds: 50), () {
      this.scrollViewController.jumpTo(this.scrollViewController.position.maxScrollExtent);
    });
  }

  boxMessage(state, index, context) {
    if (state is ReceivePublicMessageState) {
      if (!isAddPositionNameMessage &&
          widget.instance.getRoom.messages[index].user.nickname != widget.instance.getUser.nickname &&
          widget.instance.getRoom.messages[index].type == BlocEventType.receive_public_message) {
          widget.instance.getRoom.messages[index].namePosition(nameMessageCount);
        userSendMessage = widget.instance.getRoom.messages[index].user.nickname;
        nameMessageCount++;
        isAddPositionNameMessage = true;
      }
    } else if (widget.instance.getRoom.messages[index].user.nickname == widget.instance.getUser.nickname) {
      userSendMessage = widget.instance.getUser.nickname;
      nameMessageCount = 0;
    }
    if (widget.instance.getRoom.messages[index].type == BlocEventType.receive_public_message) {
      isAddPositionNameMessage = false;
      scroll();
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Stack(fit: StackFit.loose,
                  // alignment: AlignmentDirectional.centerStart,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // widget.instance.getRoom.getMessages[index].getNamePosition < 2?
                          Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 6, left: 6),
                              child: Row(children: [
                                Text(
                                    '${widget.instance.getRoom.messages[index].user.nickname}'),
                              ])),
                          Container(
                              // width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  // color: _room.getMessages[index].getUser.getNickname != _user.getNickname ?
                                  color: Colors.white,
                                  // : Color(0xffdcd9d9),
                                  border: Border.all(
                                      color: Color(0xffdcd9d9), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                  '${widget.instance.getRoom.messages[index].textMessage}'))
                          //     : Padding(
                          //     padding: const EdgeInsets.only(bottom: 0)
                          // )
                        ]),
                  ])));
    } else if (widget.instance.getRoom.messages[index].type == BlocEventType.send_public_message) {
      return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Stack(fit: StackFit.loose, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Color(0xffdcd9d9),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                        '${widget.instance.getRoom.messages[index].textMessage}'),
                  )
                ],
              ),
            ]),
          )
          // ),
          );
    } else if (widget.instance.getRoom.messages[index].type == BlocEventType.enter_public_room ||
        widget.instance.getRoom.messages[index].type == BlocEventType.leave_public_room) {
      return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Stack(fit: StackFit.loose, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                          '${widget.instance.getRoom.messages[index].textMessage}',
                          style: GoogleFonts.inter(
                              color: AppColors.white, fontSize: 10))),
                ],
              ),
            ]),
          )
          // ),
          );
    }
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
              bloc: widget.instance.bloc,
              builder: (context, state) {
                if (state is InitialState) {
                  return Expanded(child: Container());
                } else if (state is EnterRoomState) {
                   return Expanded(child: Container());
                } else {
                  return Expanded(
                      child: ListView.builder(
                          key: PageStorageKey<String>('MessagesList'),
                          controller: scrollViewController,
                          itemCount: widget.instance.getRoom.messages.length,
                          itemBuilder: (context, index) {
                            return boxMessage(state, index, context);
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
                      onChanged: (String value) {
                        // if(value.length < 30) {
                        //   instance.lineNumbers = 1;
                        // } else if(value.length < 60){
                        //   instance.lineNumbers = 2;
                        // } else if(value.length < 100){
                        //   instance.lineNumbers = 3;
                        // } else{
                        //   instance.lineNumbers = 5;
                        // }
                      },
                      focusNode: this.widget.instance.focusNode,
                      onSubmitted: (_) {
                        this.widget.instance.sendMessage(widget.instance.bloc, '');
                      },
                      controller: this.widget.instance.textController,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: this.widget.instance.lineNumbers,
                      style: GoogleFonts.inter(fontSize: 15),
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
                          this.widget.instance.sendMessage(widget.instance.bloc,'public');
                        }),
                  ),
                ),
              ]))
        ]));
  }
}
