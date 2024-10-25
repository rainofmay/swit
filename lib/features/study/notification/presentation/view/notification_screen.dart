import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/notification/presentation/viewmodel/notification_view_model.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class NotificationScreen extends GetView<NotificationViewModel> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomBackAppBar(appbarTitle: '알림', isLeading: true, isCenterTitle: true),
      body: Obx(() {
        if (controller.notificationList.isEmpty) {
          return const Center(child: Text('알림이 없습니다.'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          child: ListView.builder(
            itemCount: controller.notificationList.length,
            itemBuilder: (context, index) {
              final notification = controller.notificationList[index];
              return ListTile(
                title: Text(notification.body),
                subtitle: Text(notification.createdAt.toString()),
              );
            },
          ),
        );
      }),
    );
  }
}
