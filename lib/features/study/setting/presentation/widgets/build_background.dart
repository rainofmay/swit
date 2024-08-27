import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io' as io;

import 'package:swit/shared/widgets/custom_circular_indicator.dart';

class BuildBackground extends StatelessWidget {
  const BuildBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Obx(() {
        final imageUrl = myroomViewModel.selectedItemThumbnail.value;
        if (imageUrl.startsWith('http')) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const Center(child: CustomCircularIndicator(size: 30))
              ),
            ),
          );
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.file(
                io.File(imageUrl),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: CustomCircularIndicator(size: 30))
              ),
            ),
          );
        }
      }),
    );
  }
}
