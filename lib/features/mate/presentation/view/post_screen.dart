import 'package:flutter/material.dart';
import 'package:swit/features/mate/presentation/widgets/post_it.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostIt(),
      ],
    );
  }
}
