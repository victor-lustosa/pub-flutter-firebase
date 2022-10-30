import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../room/blocs/room_bloc.dart';
import '../../room/view-models/room_view_model.dart';

import '../../shared/components/location_util.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/infra/models/user_model.dart';

import 'components/establishment_flexible_space_bar_widget.dart';
import 'components/establishment_page_one_widget.dart';
import 'components/establishment_page_two_widget.dart';
import 'components/establishment_tab_bar_sliver_widget.dart';
import 'package:provider/provider.dart';
class EstablishmentPage extends StatefulWidget {
  EstablishmentPage(this.user);

  final UserModel user;

  @override
  _EstablishmentPageState createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollViewController;
  late TabController _tabController;

  getUser() async {
    context.read<RoomViewModel>().user = await LocationUtil.getPosition(widget.user);
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 2);
    getUser();
    context.read<RoomViewModel>().bloc.add(GetRoomsEvent());
    context.read<RoomViewModel>().delayForForms(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    context.read<RoomViewModel>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      EstablishmentFlexibleSpaceBarWidget(this.widget.user),
                ),
                bottom: EstablishmentTabBarSliverWidget(_tabController),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.darkBrown,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 133.0,
                collapsedHeight: 33,
                toolbarHeight: 33,
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: <Widget>[
            EstablishmentPageOneWidget(),
            EstablishmentPageTwoWidget()
          ])),
      // EstablishmentPageTwoWidget(this._roomViewModel, this._participantViewModel, this._bloc)])),
      floatingActionButton: SizedBox(
          height: 30,
          width: 160,
          child: FloatingActionButton.extended(
            onPressed: () {
              context.read<RoomViewModel>().openURL(context);
            },
            label: Text("Ajude com sua opinião",
                style: GoogleFonts.inter(fontSize: 10.5, color: Colors.white)),
            backgroundColor: AppColors.lightBrown,
            // icon: Icon(Icons.map, size: 15, color: Colors.white)
          )),
    );
  }
}
