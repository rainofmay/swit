import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/widgets/calendar.dart';
import 'package:swit/features/mate/presentation/widgets/post_it.dart';

class PostScreen extends GetView<MateViewModel> {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Calendar(),
      ],
    );
  }
}
