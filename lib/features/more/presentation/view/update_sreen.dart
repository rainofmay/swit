import 'package:flutter/material.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomBackAppBar(
          appbarTitle: '앱 업데이트 공지',
          isLeading: true,
          isCenterTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          children: [
            CustomGap(16),
            Row(
              children: [
                Text('v 1.0.0.'),
                SizedBox(width: 16),
                Text('Swit 모바일, 테블릿용 앱 출시')
              ],
            ),],
        ),
      ),
    );
  }
}
