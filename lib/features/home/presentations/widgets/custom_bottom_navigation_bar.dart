import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/home_tab_type.dart';
import 'package:swit/features/home/presentations/viewmodel/home_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';

class CustomBottomNavigationBar extends GetView<HomeViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = HomeTab.values.map((tab) {
      return Obx(() => _CustomBottomNavigationBarItem(
          isSelected: controller.currentTab == tab,
          tab: tab,
          onTap: () => controller.updateCurrentTab(tab)));
    }).toList();

    return Container(
        decoration: BoxDecoration(color: ColorBox.secondColor),
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgets));
  }
}

class _CustomBottomNavigationBarItem extends StatelessWidget {
  const _CustomBottomNavigationBarItem({
    required this.isSelected,
    required this.tab,
    required this.onTap,
  });

  final bool isSelected;
  final HomeTab tab;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: AnimatedCrossFade(
            alignment: Alignment.center,
            firstCurve: Curves.easeIn,
            secondCurve: Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            firstChild: _SelectedIcon(tab: tab),
            secondChild: _UnselectedIcon(tab: tab),
            crossFadeState: isSelected
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }
}

class _SelectedIcon extends StatelessWidget {
  const _SelectedIcon({required this.tab});

  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(width: 22, height: 22, tab.onIcon),
        Text(tab.label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: ColorBox.primaryColor)),
      ],
    );
  }
}

class _UnselectedIcon extends StatelessWidget {
  const _UnselectedIcon({required this.tab});

  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: 22,
      height: 22,
      tab.offIcon,
      fit: BoxFit.fitHeight,
    );
  }
}
