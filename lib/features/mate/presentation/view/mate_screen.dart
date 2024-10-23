import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/mate/presentation/view/mate_tab.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class MateScreen extends GetView<MateViewModel> {
  const MateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: CustomScaffold(
          appBar: CustomAppBar(appbarTitle: '메이트', actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.MATE + Routes.ADDMATE);
                },
                icon: const Icon(Icons.person_add_alt_1))
          ]),

          body: MateTab(),
        ),
      );
  }
}
