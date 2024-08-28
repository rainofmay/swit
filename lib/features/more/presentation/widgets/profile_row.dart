import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Anonymous');
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Obx(
    //               () => ClipRRect(
    //             borderRadius: BorderRadius.circular(50.0),
    //             child: mateViewModel.profileImageUrl.value == ''
    //                 ? Image.asset(
    //               'assets/images/themes/gomzy_theme.jpg',
    //               fit: BoxFit.cover,
    //               width: 40,
    //               height: 40,
    //             )
    //                 : CachedNetworkImage(
    //               imageUrl: mateViewModel.profileImageUrl.value,
    //               fit: BoxFit.cover,
    //               width: 40,
    //               height: 40,
    //               placeholder: (context, url) => CustomCircularIndicator(size: 30.0),
    //               errorWidget: (context, url, error) => Image.asset(
    //                 'assets/images/themes/gomzy_theme.jpg',
    //                 fit: BoxFit.cover,
    //                 width: 40,
    //                 height: 40,
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 10),
    //         Obx(() => mateViewModel.name.value.isEmpty
    //             ? const Text("로그인 후 이용하실 수 있습니다.", style: TextStyle(color: GREY))
    //             : Text(mateViewModel.name.value, style: const TextStyle(color: BLACK))
    //         )
    //       ],
    //     ),
    //   ],
    // ),
  }
}
