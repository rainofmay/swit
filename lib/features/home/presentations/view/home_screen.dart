import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/home/presentations/viewmodel/bottombar_viewmodel.dart';
import 'package:swit/core/enums/home_tab_type.dart';
import 'package:swit/features/mate/presentation/view/mate_screen.dart';
import 'package:swit/features/more/presentation/view/more.screen.dart';
import 'package:swit/features/record/presentation/view/record_screen.dart';
import 'package:swit/features/study/study_screen.dart';
import 'package:swit/features/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class HomeScreen extends GetView<BottomBarViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        // appBar: CustomAppBar(
        //   backgroundColor: ColorBox.transparent,
        //   contentColor: ColorBox.black,
        // ),
        body: Obx(() => _buildTabScreen(controller.currentTab)),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

Widget _buildTabScreen(HomeTab tab) {
  // switch 패턴 매칭
  switch (tab) {
    case HomeTab.home:
      return StudyScreen();
    case HomeTab.record:
      return const RecordScreen();
    case HomeTab.mate:
      return const MateScreen();
    case HomeTab.more:
      return const MoreScreen();
  }
}
