import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
          child: Row(
            children: [
              const CustomGap(12),
              Text(
                "Anomymous",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
              Text(
                "Account Information",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const CustomGap(16),
              Text("Name", style: Theme.of(context).textTheme.labelMedium),
              Text(
                "Anomymous",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorBox.grey,
                ),
              ),
              const CustomGap(16),
              Text("Email", style: Theme.of(context).textTheme.labelMedium),
              Text(
                "anomymous@test.com",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorBox.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
