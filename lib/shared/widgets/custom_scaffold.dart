import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const CustomScaffold({super.key, this.appBar, this.body, this.bottomNavigationBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBox.white,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
