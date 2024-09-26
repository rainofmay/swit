import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/user/domain/entities/user.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';

class ProfileCard extends StatelessWidget {
  final User profile;
  final double? width;
  final double? height;
  const ProfileCard({super.key, required this.profile, this.width, this.height});

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
              Container(
                width: width ?? 40,  // 원하는 너비
                height: height ?? 40, // 원하는 높이
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), // 모서리 둥글기 조절
                  color: ColorBox.grey.withOpacity(0.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Container와 동일한 둥글기
                  child: profile.profileUrl != null && profile.profileUrl!.isNotEmpty
                      ? Image.network(
                    profile.profileUrl!,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.person, size: 30, color: ColorBox.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.username ?? '이름이 없습니다.',
                        style: FontBox.B1.copyWith(color: ColorBox.black)),
                    profile.introduction?.isEmpty == false ? Text(profile.introduction!,
                      style: FontBox.B3.copyWith(color: ColorBox.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ) : const SizedBox(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}