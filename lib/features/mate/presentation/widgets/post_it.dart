import 'package:flutter/material.dart';
import 'package:swit/features/mate/presentation/widgets/calendar.dart';

class PostIt extends StatelessWidget {
  const PostIt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MateCalendar(),
      ],
    );
  }
}
