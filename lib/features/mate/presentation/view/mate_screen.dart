import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/view/create_post_it_screen.dart';
import 'package:swit/features/mate/presentation/view/post_screen.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class MateScreen extends StatelessWidget {
  const MateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: CustomScaffold(
          appBar: CustomAppBar(appbarTitle: '메이트'),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              Get.to(()=> CreatePostItScreen());
            },
            child: Icon(Icons.edit, color: ColorBox.black),
            elevation: 1,
            backgroundColor: ColorBox.white,
          ),
          body: Column(
            children: [
              TabBar(
                isScrollable: false,
                labelColor: ColorBox.primaryColor,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: ColorBox.grey,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.person_2_rounded,
                      size: IconSize.md,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.local_post_office_outlined,
                      size: IconSize.md,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      size: IconSize.md,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      size: IconSize.md,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const PostScreen(),
                    const PostScreen(),
                    const PostScreen(),
                    const PostScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
