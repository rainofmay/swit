import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swit/features/more/presentation/widgets/profile_row.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(appbarTitle: '더보기'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileRow(),
          Divider(
            height: 1,
            color: ColorBox.grey[400],
          ),
          const CustomGap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TapRow(
                    widget:
                        Icon(CupertinoIcons.person_circle, size: IconSize.md),
                    title: '내 정보 관리',
                    onTap: () {}),
                const CustomGap(32),
                TapRow(
                    widget: Icon(Icons.update, size: IconSize.md),
                    title: '업데이트 공지',
                    onTap: () {}),
                const CustomGap(32),
                TapRow(
                    widget: Icon(Icons.payment_rounded, size: IconSize.md),
                    title: '구매 내역',
                    onTap: () {}),
                const CustomGap(32),
                TapRow(
                    widget: Icon(CupertinoIcons.pencil, size: IconSize.md),
                    title: 'Swit에 제안하기',
                    onTap: () {}),
                const CustomGap(32),
                TapRow(
                    widget: Icon(Icons.login_rounded, size: IconSize.md),
                    title: '로그인',
                    onTap: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
