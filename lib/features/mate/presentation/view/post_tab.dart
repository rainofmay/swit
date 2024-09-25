import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/viewmodel/post_tab_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/calendar.dart';
import 'package:swit/features/mate/presentation/widgets/post_it.dart';

class PostTab extends GetView<PostTabViewModel> {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MateCalendar(),
      ],
    );
  }
}
