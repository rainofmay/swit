import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/mate/presentation/view/create_post_it_screen.dart';
import 'package:swit/features/mate/presentation/view/mate_tab.dart';
import 'package:swit/features/mate/presentation/view/post_tab.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class MateScreen extends GetView<MateViewModel> {
  MateScreen({super.key});

  final List<IconData> tabIcons = [
    Icons.person_2_rounded,
    Icons.local_post_office_outlined,
    Icons.notifications_active_outlined,
    Icons.notifications_active_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            controller.updateTapIndex(tabController.index);
          });

          return SafeArea(
              child: Obx(
            () => CustomScaffold(
              appBar: CustomAppBar(appbarTitle: '메이트'),
              floatingActionButton: controller.tabIndex == 1
                  ? FloatingActionButton.small(
                      onPressed: () {
                        Get.toNamed(Routes.MATE + Routes.CREATEPOSTIT);
                      },
                      child: Icon(Icons.edit, color: ColorBox.black),
                      elevation: 1,
                      backgroundColor: ColorBox.white,
                    )
                  : null,
              body: Column(
                children: [
                  TabBar(
                      isScrollable: false,
                      labelColor: ColorBox.primaryColor,
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: ColorBox.grey,
                      tabs: tabIcons
                          .map((icon) =>
                              Tab(icon: Icon(icon, size: IconSize.md)))
                          .toList()),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const MateTab(),
                        const PostTab(),
                        const PostTab(),
                        const PostTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        }));
  }
}
