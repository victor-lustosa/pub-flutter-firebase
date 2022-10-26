import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../room/blocs/room_bloc.dart';
import '../../room/domain/use-cases/room_use_cases.dart';
import '../../room/external/room_firestore_datasource.dart';
import '../../room/infra/repositories/room_repository.dart';
import '../../room/view-models/room_view_model.dart';

import '../../shared/components/location_util.dart';
import '../../shared/configs/app_colors.dart';
import '../../user/infra/models/user_model.dart';

import 'components/establishment_flexible_space_bar_widget.dart';
import 'components/establishment_page_one_widget.dart';
import 'components/establishment_page_two_widget.dart';
import 'components/establishment_tab_bar_sliver_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late final RoomViewModel _roomViewModel;

  getUser() async {
    _roomViewModel = RoomViewModel(
        bloc: RoomBloc(
            roomUseCases: RoomUseCases(
                repository: RoomRepository(
                    datasource: RoomFirestoreDatasource(
                        firestore: FirebaseFirestore.instance)))));
    _roomViewModel.setUser(await LocationUtil.getPosition(widget.user));
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 2);
    getUser();
    _roomViewModel.bloc.add(GetRoomsEvent());
    _roomViewModel.delayForForms(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _roomViewModel.bloc.close();
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
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.darkBrown,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 133.0,
                collapsedHeight: 33,
                toolbarHeight: 33,
                bottom: EstablishmentTabBarSliverWidget(_tabController),
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: <Widget>[
            EstablishmentPageOneWidget(roomViewModel: _roomViewModel),
            EstablishmentPageTwoWidget()
          ])),
      // EstablishmentPageTwoWidget(this._roomViewModel, this._participantViewModel, this._bloc)])),
      floatingActionButton: SizedBox(
          height: 30,
          width: 160,
          child: FloatingActionButton.extended(
            onPressed: () {
              _roomViewModel.openURL(context);
            },
            label: Text("Ajude com sua opinião",
                style: GoogleFonts.inter(fontSize: 10.5, color: Colors.white)),
            backgroundColor: AppColors.lightBrown,
            // icon: Icon(Icons.map, size: 15, color: Colors.white)
          )),
    );
  }
}
