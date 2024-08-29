import 'package:flutter/material.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class MateScreen extends StatelessWidget {
  const MateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(appbarTitle: '메이트'),
    );
  }
}
