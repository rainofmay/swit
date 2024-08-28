import 'package:flutter/material.dart';
import 'package:swit/features/more/presentation/widgets/profile_row.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/tap_row.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        isCenterTitle: false,
        appbarTitle: '더보기',
        contentColor: ColorBox.black,
      ),
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
                TapRow(title: '내 정보 관리', onTap: () {}),
                const CustomGap(16),
                TapRow(title: '업데이트 공지', onTap: () {}),
                const CustomGap(16),
                TapRow(title: '구매 내역', onTap: () {}),
                const CustomGap(16),
                TapRow(title: 'Swit에 제안하기', onTap: () {}),
                const CustomGap(16),
                TapRow(title: '로그인', onTap: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
