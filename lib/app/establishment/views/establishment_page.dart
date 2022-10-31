import 'package:flutter/material.dart';

import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_images.dart';
import '../../shared/configs/app_routes.dart';

import '../blocs/establishment_bloc.dart';
import '../view-models/establishment_view_model.dart';
import 'components/establishment_page_one_widget.dart';
import 'components/establishment_page_two_widget.dart';
import 'components/establishment_tab_bar_sliver_widget.dart';
import 'package:provider/provider.dart';

class EstablishmentPage extends StatefulWidget {

  @override
  _EstablishmentPageState createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 2);
    context.read<EstablishmentViewModel>().getUser();
    context.read<EstablishmentViewModel>().bloc.add(GetRoomsEvent());
    context.read<EstablishmentViewModel>().delayForForms(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    context.read<EstablishmentViewModel>().dispose();
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
                    background: Stack(
                  alignment: Alignment.centerLeft,
                  fit: StackFit.loose,
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 45, left: 60),
                            child: Text("APP",
                                style: AppFonts.appTitle)),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 50, top: 25),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.editUserRoute,
                                  ModalRoute.withName(
                                      AppRoutes.establishmentRoute),
                                  arguments: context.read<EstablishmentViewModel>().user);
                            },
                            iconSize: 45,
                            icon: ClipOval(
                              child: Image.asset(AppImages.userAvatar,
                                  width: 45, height: 45),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 115),
                            child: Text(context.read<EstablishmentViewModel>().user.nickname,
                                style: AppFonts.nicknameDisabled)),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: <Widget>[
                    //     Padding(
                    //         padding: const EdgeInsets.only(left: 0,bottom: 65),
                    //         child: IconButton(
                    //           iconSize: 30,
                    //           icon: Icon(Icons.search_rounded, color: Colors.white, size: 23),
                    //           onPressed: ()  {
                    //           },
                    //         )
                    //     ),
                    //     Padding(
                    //         padding: const EdgeInsets.only(right: 5,bottom: 65),
                    //         child: IconButton(
                    //           iconSize: 30,
                    //           icon: Icon(Icons.menu, color: Colors.white, size: 24),
                    //           onPressed: ()  {
                    //           },
                    //         )
                    //     ),
                    //   ],
                    // )
                  ],
                )),
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
            onPressed: () {},
            label: Text("visão em mapa",
                style: AppFonts.mapsButton),
            backgroundColor: AppColors.lightBrown,
            // icon: Icon(Icons.map, size: 15, color: Colors.white)
          )),
    );
  }
}
