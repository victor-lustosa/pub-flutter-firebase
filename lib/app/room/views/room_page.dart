import 'package:flutter/material.dart';
import '../../room/blocs/room_bloc.dart';
import '../../room/views/components/room_page_one_widget.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../view-models/room_view_model.dart';
import 'components/room_page_two_widget.dart';
import 'components/room_tab_bar_sliver_widget.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  RoomPage();

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with SingleTickerProviderStateMixin {
  double offset = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<RoomViewModel>().bloc.add(EnterRoomEvent(
        user: context.read<RoomViewModel>().user,
        room: context.read<RoomViewModel>().room));
    _tabController = TabController(vsync: this, length: 2);
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
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                                padding: EdgeInsets.only(top: 0),
                                child: IconButton(
                                    iconSize: 30,
                                    icon: Icon(
                                      Icons.navigate_before_rounded,
                                      color: AppColors.darkBrown,
                                    ),
                                    color: AppColors.darkBrown,
                                    onPressed: () {
                                      context.read<RoomBloc>().add(
                                          LeaveRoomEvent(user:
                                          context.read<RoomViewModel>().user,
                                              room: context.read<RoomViewModel>().room));
                                      Navigator.pop(context);
                                    }))
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
                                padding: EdgeInsets.only(left: 48),
                                child: Text(
                                  context.read<RoomViewModel>().room.name,
                                  style: AppFonts.roomName))
                          ],
                        ),
                      ])),
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.white,
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: 67.0,
                  collapsedHeight: 67,
                  toolbarHeight: 67,
                  bottom: RoomTabBarSliverWidget(_tabController),
                )
              ];
            },
            body: TabBarView(controller: _tabController, children: <Widget>[
              RoomPageOneWidget(),
              RoomPageTwoWidget(),
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
            ])));
  }
}
