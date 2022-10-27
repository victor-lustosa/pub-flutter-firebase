import 'package:flutter/material.dart';

import '../../shared/components/chat_mixin.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/infra/models/user_model.dart';
import '../blocs/participant_bloc.dart';
import '../view-models/participant_view_model.dart';
import 'components/participant_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticipantPage extends StatefulWidget {
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
            title: ParticipantBarWidget(_participantViewModel.participant)),
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
                                alignment: alignment(state, index, widget.user),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                              this._participantViewModel.sendMessage(_participantViewModel.bloc);
                            }),
                      ),
                    ),
                  ]))
            ])));
  }
}
