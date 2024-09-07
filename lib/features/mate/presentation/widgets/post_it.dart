import 'package:flutter/material.dart';

class PostIt extends StatelessWidget {
  const PostIt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/post_it.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Text('쪽지 테스트')
    );
  }
}
