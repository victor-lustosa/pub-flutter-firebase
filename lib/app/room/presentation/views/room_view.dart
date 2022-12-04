import 'package:flutter/material.dart';
import '../../../room/presentation/blocs/room_bloc.dart';
import '../../../shared/configs/app_configs.dart';

import '../view-models/room_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../../../shared/mixins/chat_mixin.dart';
import '../../../participant/infra/models/dto/participant_dto.dart';

import '../../../shared/configs/app_routes.dart';

class RoomView extends StatefulWidget {
  const RoomView({super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView>
    with SingleTickerProviderStateMixin {
  double offset = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<RoomViewModel>().bloc.add(
          EnterRoomEvent(
            user: context.read<RoomViewModel>().user,
            room: context.read<RoomViewModel>().room,
          ),
        );
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
    context.read<RoomViewModel>().bloc.add(
          GetMessagesEvent(room: context.read<RoomViewModel>().room),
        );
    context.read<RoomViewModel>().bloc.add(
          GetParticipantsEvent(room: context.read<RoomViewModel>().room),
        );
    context.read<RoomViewModel>().scrollViewController =
        ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(
                              Icons.navigate_before_rounded,
                              color: AppColors.darkBrown,
                            ),
                            color: AppColors.darkBrown,
                            onPressed: () {
                              context.read<RoomBloc>().add(
                                    LeaveRoomEvent(
                                      user: context.read<RoomViewModel>().user,
                                      room: context.read<RoomViewModel>().room,
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // CircleAvatar(
                        //     maxRadius: 20,
                        //     backgroundColor: Colors.grey,
                        //     backgroundImage: widget.contato.urlImagem != null
                        //         ? NetworkImage(widget.contato.urlImagem)
                        //         : null),

                        Padding(
                          padding: const EdgeInsets.only(left: 48),
                          child: Text(
                            context.read<RoomViewModel>().room.name,
                            style: AppFonts.roomName,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.white,
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: 67.0,
              collapsedHeight: 67,
              toolbarHeight: 67,
              bottom: TabBarSliverWidget(_tabController),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ChatPageWidget(),
            ParticipantsListWidget(),
            // Visibility(visible: true,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: AppColors.brown,
            //           borderRadius: BorderRadius.all(const Radius.circular(10.0))),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           IconButton(onPressed:() {}, icon: Icon(Icons.remove,size: 10,color: Color(0xFFFFFFFF),))
            //         ],
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}

class TabBarSliverWidget extends PreferredSize {
  final TabController tabController;

  TabBarSliverWidget(this.tabController, {super.key})
      : super(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: TabBar(
              controller: tabController,
              // isScrollable: true,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ), // Creates border
                color: AppColors.lightBrown,
              ),
              indicatorWeight: 0,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: AppFonts.tabBarLabelStyle,
              unselectedLabelStyle: AppFonts.tabBarLabelStyle,
              indicatorColor: AppColors.darkBrown,
              labelColor: AppColors.white,
              unselectedLabelColor: Colors.grey,
              tabs: const <Widget>[
                SizedBox(
                  height: 18.0,
                  width: 120,
                  child: Tab(
                    text: "sala",
                  ),
                ),
                SizedBox(
                  height: 18.0,
                  width: 120,
                  child: Tab(
                    text: "participantes",
                  ),
                )
              ],
            ),
          ),
        );
}

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({super.key});

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
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          BlocConsumer<RoomBloc, RoomState>(
            bloc: context.read<RoomBloc>(),
            listener: (context, state) {
              if (state is SuccessfullyFetchedMessagesState) {
                context.read<RoomViewModel>().fetchMessagesList(state.messages);
              }
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  key: const PageStorageKey<String>('MessagesList'),
                  controller: context.read<RoomViewModel>().scrollViewController,
                  itemCount: context.read<RoomViewModel>().messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: crossAlignment(
                        context.read<RoomViewModel>().messages![index],
                        context.read<RoomViewModel>().user,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
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
                                  child: Text(
                                    context
                                        .read<RoomViewModel>()
                                        .messages![index]
                                        .user
                                        .nickname,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: colorMessage(
                                    context
                                        .read<RoomViewModel>()
                                        .messages![index],
                                    context.read<RoomViewModel>().user,
                                  ),
                                  border: Border.all(
                                      color: const Color(0xffdcd9d9), width: 1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  context
                                      .read<RoomViewModel>()
                                      .messages![index]
                                      .textMessage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 8,
                    ),
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
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                        hintText: "Digite uma mensagem...",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
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
                      mini: true,
                      onPressed: () {
                        context.read<RoomViewModel>().sendMessage();
                        context.read<RoomViewModel>().scroll();
                      },
                      child: const Icon(
                        Icons.near_me_outlined,
                        size: 29,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParticipantsListWidget extends StatelessWidget {
  const ParticipantsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
           if (state is SuccessfullyFetchedParticipantsState) {
              context.read<RoomViewModel>().fetchParticipants(state.participants);
            }
        },
        bloc: context.read<RoomBloc>(),
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: context.read<RoomViewModel>().participants?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    bottom: 10,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.asset(
                      AppImages.userAvatar,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    context.read<RoomViewModel>().participants![index].nickname,
                    style: AppFonts.roomNickname,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.privateRoomRoute,
                    arguments: ParticipantDTO(
                      user: context.read<RoomViewModel>().participants![index],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
