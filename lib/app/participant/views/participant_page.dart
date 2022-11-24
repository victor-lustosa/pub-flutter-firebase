import 'package:flutter/material.dart';

import '../../shared/mixins/chat_mixin.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../../user/infra/models/user_model.dart';
import '../blocs/participant_bloc.dart';
import '../view-models/participant_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*class ParticipantPage extends StatefulWidget {
  final UserModel user;
  ParticipantPage({required this.user});

  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> with ChatMixin{

  late final ScrollController _scrollViewController;
  late final ParticipantViewModel _participantViewModel;
  @override
  void initState() {
    // widget.bloc.add(EnterPrivateRoomEvent(widget.participantViewModel));
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    //_bloc = ParticipantBloc(sendPrivateMessage: sendPrivateMessage);
  //  _participantViewModel = ParticipantViewModel(participant: widget.user,bloc: );
    super.initState();
  }

  @override
  void dispose() {
    // widget.bloc.add(LeaveRoomEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                // CircleAvatar(
                //     maxRadius: 20,
                //     backgroundColor: Colors.grey,
                //     backgroundImage: widget.contato.urlImagem != null
                //         ? NetworkImage(widget.contato.urlImagem)
                //         : null),
                Padding(
                    padding: EdgeInsets.only(top: 0, right: 0),
                    child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.navigate_before_rounded,
                          color: AppColors.darkBrown,
                        ),
                        color: AppColors.darkBrown,
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                        _participantViewModel.participant.nickname,
                        style:AppFonts.participantNickname
                    )
                )
              ],
            )),
        body: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              BlocBuilder<ParticipantBloc, ParticipantState>(
                  bloc: _participantViewModel.bloc,

                  builder: (context, state) {
                    if (state is InitialState) {
                      return Expanded(child: Container());
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            controller: _scrollViewController,
                            itemCount: _participantViewModel.participant.messages.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: alignment(state, widget.user),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          color: color(state, index, widget.user),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: _participantViewModel.typeMessage(state, index)),
                                ),
                              );
                            }),
                      );
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
                          focusNode: _participantViewModel.focusNode,
                          onSubmitted: (_) {
                            this._participantViewModel.sendMessage(_participantViewModel.bloc);
                          },
                          controller:
                              this._participantViewModel.textController,
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines:
                              this._participantViewModel.lineNumbers,
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
                              this._participantViewModel.sendMessage(_participantViewModel.bloc);
                            }),
                      ),
                    ),
                  ]))
            ])));
  }
}
*/