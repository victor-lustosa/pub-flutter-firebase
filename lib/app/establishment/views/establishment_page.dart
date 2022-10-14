import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../room/view-models/room_view_model.dart';
import '../../user/infra/models/user_model.dart';

import '../../room/blocs/room_bloc.dart';
import '../../participant/models/participant.dart';
import '../../participant/view-models/participant_view_model.dart';
import '../../room/models/room.dart';
import '../blocs/establishment_bloc.dart';
import '../domain/use-cases/get_establishments.dart';
import '../view-models/establishment_view_model.dart';
import 'components/establishment_flexible_space_bar_widget.dart';
import 'components/establishment_page_one_widget.dart';
import 'components/establishment_page_two_widget.dart';
import 'components/establishment_tab_bar_sliver_widget.dart';

class EstablishmentPage extends StatefulWidget {
  EstablishmentPage(this.user);

  final UserModel user;

  @override
  _EstablishmentPageState createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollViewController;
  late final EstablishmentBloc _bloc;
  late TabController _tabController;

  late final EstablishmentViewModel _establishmentViewModel;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);

    /*this._participantViewModel = ParticipantViewModel(
        user: widget.user,
        participant: Participant.withoutParameters());
    _bloc = EstablishmentBloc(getEstablishmentsUseCase: _getEstablishments);
    _bloc.add(GetEstablishmentsEvent());
    _tabController = TabController(vsync: this, length: 2);
    _establishmentViewModel.delayForForms(context);*/
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bloc.close();
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
            EstablishmentPageOneWidget(),
            EstablishmentPageTwoWidget()
          ])),
      // EstablishmentPageTwoWidget(this._roomViewModel, this._participantViewModel, this._bloc)])),
      floatingActionButton: SizedBox(
          height: 30,
          width: 160,
          child: FloatingActionButton.extended(
            onPressed: () {
              _establishmentViewModel.openURL(context);
            },
            label: Text("Ajude com sua opinião",
                style: GoogleFonts.inter(fontSize: 10.5, color: Colors.white)),
            backgroundColor: AppColors.lightBrown,
            // icon: Icon(Icons.map, size: 15, color: Colors.white)
          )),
    );
  }
}
