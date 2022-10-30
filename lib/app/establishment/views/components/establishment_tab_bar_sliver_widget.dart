import 'package:flutter/material.dart';
import 'package:pub/app/shared/configs/app_fonts.dart';

import '../../../shared/configs/app_colors.dart';

class EstablishmentTabBarSliverWidget extends PreferredSize {
  final TabController tabController;

  EstablishmentTabBarSliverWidget(this.tabController)
      : super(
            preferredSize: Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TabBar(
                controller: tabController,
                // isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)), // Creates border
                    color: AppColors.white),
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: AppFonts.tabBarLabelStyle,
                unselectedLabelStyle: AppFonts.tabBarLabelStyle,
                indicatorColor: AppColors.darkBrown,
                labelColor: AppColors.darkBrown,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Container(
                      height: 23.0,
                      width: 160,
                      child: Tab(
                        text: "salas disponíveis",
                      )),
                  Container(
                      height: 23.0,
                      width: 140,
                      child: Tab(
                        text: "salas privadas",
                      ))
                ],
              ),
            ));
}
