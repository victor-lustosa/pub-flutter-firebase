import 'package:flutter/material.dart';
import '../../../shared/configs/app_fonts.dart';
import '../../../shared/configs/app_colors.dart';

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
