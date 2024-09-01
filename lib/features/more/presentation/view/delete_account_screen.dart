import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_check_box.dart';
import 'package:swit/shared/widgets/custom_dialog.dart';
import 'package:swit/shared/widgets/custom_gap.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';
import 'package:swit/shared/widgets/ok_cancel._buttons.dart';
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomScaffold(
      appBar: const CustomBackAppBar(
        isLeading: true,
        appbarTitle: 'Swit 탈퇴',
        isCenterTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGap(16),
                Text('탈퇴 시 유의사항', style: FontBox.TITLESTYLE),
                CustomGap(32),
                Text(
                    '1. 배경화면, 프로필 등 사용자가 설정한 데이터, 일정, 공부 일지, 메이트 등에 관한 모든 정보는 사라지며 복구할 수 없습니다.',
                    style: FontBox.CONTENTSTYLE,
                    softWrap: true),
                CustomGap(32),
                Text('2. 본 애플리케이션 서비스는 귀하의 탈퇴 이후 개인정보 저장, 활용 등의 행위를 일체 하지 않습니다.',
                    style: FontBox.CONTENTSTYLE, softWrap: true),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  CustomCheckBox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    radius: 50,
                  ),
                  Text('탈퇴 시 유의사항을 모두 확인하였습니다.',
                      style: TextStyle(color: _isChecked ? ColorBox.black : ColorBox.grey))
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  minimumSize: Size(screenWidth, 50),
                  backgroundColor: ColorBox.black,
                ),
                child: Text(
                  '탈퇴하기',
                  style:
                  TextStyle(fontSize: 16, color: _isChecked ? ColorBox.white : ColorBox.grey),
                ),
                onPressed: () {
                  _isChecked
                      ? customDialog(
                      context,
                      30,
                      '정말 탈퇴하시겠습니까?',
                      const Text('탈퇴하면 모든 정보가 삭제됩니다.',
                          style: TextStyle(color: Colors.transparent)),
                      OkCancelButtons(
                        okTextColor: ColorBox.primaryColor,
                        okText: '확인',
                        onPressed: () async {
                          Get.back();
                          // await loginViewModel.deleteAccount(context);
                          // Get.offAll(() => LoginScreen());
                        },
                        cancelText: '취소',
                      ))
                      : null;
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
