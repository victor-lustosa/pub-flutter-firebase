import 'dart:async';

import 'package:flutter/material.dart';

import '../../room/blocs/room_bloc.dart';

import '../../room/views/components/room_page_one_widget.dart';
import '../../shared/configs/app_colors.dart';
import '../view-models/room_view_model.dart';
import 'components/room_bar_widget.dart';
import 'components/room_page_two_widget.dart';
import 'components/room_tab_bar_sliver_widget.dart';

class RoomPage extends StatefulWidget {
  final RoomBloc bloc;
  final RoomViewModel roomViewModel;

  RoomPage({required this.bloc, required this.roomViewModel});

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with SingleTickerProviderStateMixin{
  double offset = 0.0;
  late StreamSubscription mSub;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(
        EnterRoomEvent(
         user:  widget.roomViewModel.getUser,
         room:  widget.roomViewModel.getRoom
        )
    );

    mSub = widget.bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });
     _tabController = TabController(vsync: this, length: 2);

  }

  @override
  void dispose() {
    mSub.cancel();
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
                    background: RoomBarWidget(this.widget.bloc, this.widget.roomViewModel)),
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
              RoomPageOneWidget(this.widget.roomViewModel, this.widget.bloc,this.mSub),
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
              RoomPageTwoWidget(this.widget.roomViewModel, this.widget.bloc)
            ])));
  }
}
