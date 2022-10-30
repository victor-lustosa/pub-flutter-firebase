import 'package:flutter/material.dart';

import '../../room/blocs/room_bloc.dart';

import '../../room/views/components/room_page_one_widget.dart';
import '../../shared/configs/app_colors.dart';
import '../view-models/room_view_model.dart';
import 'components/room_bar_widget.dart';
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
        user: context.read<RoomViewModel>().user, room: context.read<RoomViewModel>().room));

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
                      background: RoomBarWidget(context.read<RoomViewModel>())),
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
