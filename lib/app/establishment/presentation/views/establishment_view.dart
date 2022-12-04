import 'package:flutter/material.dart';

import '../../../room/presentation/view-models/room_view_model.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

import '../blocs/establishment_bloc.dart';
import '../view-models/establishment_view_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/location_util.dart';

// import '../repositories/establishment_repository_dto.dart';
// import '../view-models/establishment_view_model.dart';

class EstablishmentView extends StatefulWidget {
  const EstablishmentView({super.key});

  @override
  State<EstablishmentView> createState() => _EstablishmentViewState();
}

class _EstablishmentViewState extends State<EstablishmentView>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(
      vsync: this,
      length: 2,
    );

    context.read<EstablishmentViewModel>().getUser();
    context.read<EstablishmentViewModel>().bloc.add(GetRoomsEvent());
    //context.read<EstablishmentViewModel>().delayForForms(context);
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
                          padding: const EdgeInsets.only(
                            top: 45,
                            left: 60,
                          ),
                          child: Text(
                            "APP",
                            style: AppFonts.appTitle,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                            top: 25,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.editUserRoute,
                                ModalRoute.withName(
                                  AppRoutes.establishmentRoute,
                                ),
                                arguments:
                                    context.read<EstablishmentViewModel>().user,
                              );
                            },
                            iconSize: 45,
                            icon: ClipOval(
                              child: Image.asset(
                                AppImages.userAvatar,
                                width: 45,
                                height: 45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 115,
                          ),
                          child: Text(
                            context
                                .read<EstablishmentViewModel>()
                                .user
                                .nickname,
                            style: AppFonts.nicknameDisabled,
                          ),
                        ),
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
                ),
              ),
              bottom: TabBarSliverWidget(
                _tabController,
              ),
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
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            RoomsListWidget(),
            ParticipantsChatsWidget(),
          ],
        ),
      ),
      // EstablishmentPageTwoWidget(this._roomViewModel, this._participantViewModel, this._bloc)])),
      floatingActionButton: SizedBox(
        height: 30,
        width: 160,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            "visão em mapa",
            style: AppFonts.mapsButton,
          ),
          backgroundColor: AppColors.lightBrown,
          // icon: Icon(Icons.map, size: 15, color: Colors.white)
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
            Radius.circular(10),
          ),
          // Creates border
          color: AppColors.white,
        ),
        indicatorWeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppFonts.tabBarLabelStyle,
        unselectedLabelStyle: AppFonts.tabBarLabelStyle,
        indicatorColor: AppColors.darkBrown,
        labelColor: AppColors.darkBrown,
        unselectedLabelColor: Colors.grey,
        tabs: const <Widget>[
          SizedBox(
            height: 23.0,
            width: 160,
            child: Tab(
              text: "salas disponíveis",
            ),
          ),
          SizedBox(
            height: 23.0,
            width: 140,
            child: Tab(
              text: "salas privadas",
            ),
          ),
        ],
      ),
    ),
  );
}

class RoomsListWidget extends StatelessWidget {
  const RoomsListWidget({super.key});

  //late StreamSubscription mSub;

  /*mSub = bloc.stream.listen((state) {
      if (state is LeavePublicRoomMessageState) this.mSub.cancel();
    });*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBrown,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
          bloc: context.read<EstablishmentBloc>(),
          buildWhen: (context, current) => (current is SuccessfullyFetchedRoomsState),
          builder: (context, state) {
            if (state is SuccessfullyFetchedRoomsState) {
              context.read<EstablishmentViewModel>().rooms =
                  LocationUtil.calculateDistance(
                    state.entities,
                    context.read<EstablishmentViewModel>().user,
                  );

              return RefreshIndicator(
                color: AppColors.darkBrown,
                onRefresh: () async {
                  context.read<EstablishmentViewModel>().bloc.add(
                    GetRoomsEvent(),
                  );
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:
                  context.read<EstablishmentViewModel>().rooms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AnimatedBuilder(
                        animation: context.read<EstablishmentViewModel>(),
                        builder: (context, child) {
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
                                      offset: const Offset(1, 3),
                                    ),
                                  ],
                                ),
                                child: context.read<EstablishmentViewModel>()
                                    .rooms[index]
                                    .isAcceptedLocation
                                    ? Image.asset(AppImages.lightLogo,
                                    width: 20, height: 20)
                                    : Image.asset(
                                  AppImages.lightUnauthorizedLogo,
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
                                context.read<EstablishmentViewModel>()
                                    .rooms[index]
                                    .name,
                                style: context.read<EstablishmentViewModel>()
                                    .rooms[index]
                                    .isAcceptedLocation
                                    ? AppFonts.roomEnabledName
                                    : AppFonts.roomDisabledName,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  context.read<EstablishmentViewModel>()
                                      .rooms[index]
                                      .participants
                                      .length == 1
                                      ? '${context.read<EstablishmentViewModel>().rooms[index].participants.length} pessoa'
                                      : '${context.read<EstablishmentViewModel>().rooms[index].participants.length} pessoas',
                                  style: AppFonts.numberParticipants,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Text(
                                    '${(context.read<EstablishmentViewModel>().rooms[index].distance).toStringAsFixed(2)} km de distância',
                                    style: AppFonts.distanceLabel,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (!context.read<EstablishmentViewModel>().verifyNameUser(
                                context.read<EstablishmentViewModel>().rooms[index],
                              )) {
                                context.read<RoomViewModel>().user = context.read<EstablishmentViewModel>().user;
                                context.read<RoomViewModel>().room = context.read<RoomViewModel>().room.copyWith(
                                  distance: context.read<EstablishmentViewModel>().room.distance,
                                  id: context.read<EstablishmentViewModel>().room.id,
                                  name: context.read<EstablishmentViewModel>().room.name,
                                  isAcceptedLocation: context.read<EstablishmentViewModel>().room.isAcceptedLocation,
                                  latitude: context.read<EstablishmentViewModel>().room.latitude,
                                  longitude: context.read<EstablishmentViewModel>().room.longitude
                                );
                                Navigator.pushNamed(
                                  context, AppRoutes.publicRoomRoute,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Seu nickname já existe na sala, altere-o para entrar'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return RefreshIndicator(
                color: AppColors.darkBrown,
                onRefresh: () async {
                  context.read<EstablishmentViewModel>().bloc.add(
                    GetRoomsEvent(),
                  );
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.darkBrown),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ParticipantsChatsWidget extends StatelessWidget {
  const ParticipantsChatsWidget({super.key});

  // EstablishmentViewModel _establishmentViewModel = EstablishmentViewModel(DioEstablishmentRepository(Dio()));
  // late List<dynamic> _establishments;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      decoration: const BoxDecoration(color: AppColors.darkBrown),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// import '../../../../shared/configs/app_colors.dart';
// import '../../../../shared/configs/app_images.dart';
// import '../../../../shared/configs/app_routes.dart';
// import '../../../../shared/room_bloc/stablishment_bloc.dart';
// import '../../../participant/view-models/participant_view_model.dart';
// import '../../../room/view-models/room_view_model.dart';
// // import '../../repositories/establishment_repository_dto.dart';
// // import '../../view-models/establishment_view_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class EstablishmentPageTwoWidget extends StatefulWidget {
//
//   EstablishmentPageTwoWidget(this.roomViewModel, this.participantViewModel, this.bloc);
//   final RoomViewModel roomViewModel;
//   final ParticipantViewModel participantViewModel;
//   final RoomBloc bloc;
//   // EstablishmentViewModel _establishmentViewModel = EstablishmentViewModel(DioEstablishmentRepository(Dio()));
//   // late List<dynamic> _establishments;
//
//   @override
//   State<EstablishmentPageTwoWidget> createState() => _EstablishmentPageTwoWidgetState();
// }
//
// class _EstablishmentPageTwoWidgetState extends State<EstablishmentPageTwoWidget> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: AppColors.white,
//         ),
//         child:BlocBuilder<RoomBloc,RoomState>(
//             bloc: widget.bloc,
//             buildWhen: (context, current) => context.runtimeType != current.runtimeType &&
//                 (current is InitialState ||
//                     current is SuccessRoomsState ||
//                     current is DisconnectState ||
//                     current is EnterPublicRoomMessageState ||
//                     current is LeavePublicRoomMessageState
//                 ),
//             builder:(context, state) {
//               if(state is InitialState) {
//                 return Stack(
//                     fit: StackFit.loose,
//                     alignment: Alignment.center,
//                     children: [
//                       Column( children: [
//                         Padding(
//                             padding: EdgeInsets.only(top: 270),
//                             child: Center(
//                                 child: CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkBrown))
//                             ))
//                       ])
//                     ]);
//               } else if(state is SuccessRoomsState ||
//                   state is EnterPublicRoomMessageState ||
//                   state is DisconnectState||
//                   state is LeavePublicRoomMessageState) {
//                 return ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: widget.roomViewModel.getRoom.getParticipants.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                           padding: const EdgeInsets.only(bottom: 12.0),
//                           child: AnimatedBuilder(
//                               animation: this.widget.roomViewModel,
//                               builder: (context, child) {
//                                 return ListTile(
//                                     leading: Padding(
//                                         padding: EdgeInsets.only(left: 25, bottom: 10),
//                                         child: Container(
//                                           width: 40,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                             color: AppColors.white,
//                                             borderRadius: BorderRadius.all(const Radius.circular(5.0)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey.withOpacity(0.15),
//                                                 spreadRadius: 1,
//                                                 blurRadius: 3,
//                                                 offset: Offset(1, 3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Image.asset(
//                                               AppImages.userAvatar, width: 20,
//                                               height: 20),)),
//                                     title: Padding(
//                                         padding: EdgeInsets.only(bottom: 10),
//                                         child: Text(widget.roomViewModel.getRoom.getParticipants[index].getNickname,
//                                             style: AppFonts.participantNicknamePageTwo)
//                                     ),
//                                     // subtitle:Row(
//                                     //   children: [
//                                     //     Text( 'pessoas',
//                                     //         style:AppFonts.distanceLabelPageTwo),
//                                     //     Padding(
//                                     //         padding: EdgeInsets.only(left: 40) ,
//                                     //         child: Text('3.2 km de distância',
//                                     //             style:)
//                                     //     ),
//                                     //   ],
//                                     // ),
//                                     onTap: () {
//                                       // widget.participantViewModel.setParticipant(widget.roomViewModel.getRoom.getParticipants[index]);
//                                       // Navigator.pushNamed(context, AppRoutes.PRIVATE_ROOM_ROUTE,arguments:
//                                       // ParticipantDTO(
//                                       //     bloc: widget.bloc,
//                                       //     participantViewModel: this.widget.participantViewModel));
//                                     }
//                                 );
//                               }
//                           ));
//                     });} else{
//                 return Text('aconteceu um erro [Establishment_page_one]');
//               }
//             }
//         ));
//   }
// }
