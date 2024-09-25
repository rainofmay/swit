import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class ProfileCard extends StatelessWidget {
  final User profile;
  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {

          },
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorBox.grey.withOpacity(0.5),
                      backgroundImage:
                      NetworkImage(profile.profileUrl ?? ''), // null 처리
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.username ?? '이름이 없습니다.', // null 처리
                            style: FontBox.B1.copyWith(color: ColorBox.black)),
                        Text(
                          profile.introduction?.isEmpty == false
                              ? profile.introduction!
                              : '소개가 없습니다.',
                          style: FontBox.B2.copyWith(color: ColorBox.grey)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
