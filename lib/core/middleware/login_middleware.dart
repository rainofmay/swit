import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';


class LoginMiddleware extends GetMiddleware {
  final loginService = Get.put(LoginService());

  @override
  RouteSettings? redirect(String? route) {
    // final loginService = Get.put(LoginService);

    if (!loginService.isLoggedIn()) {
      // 사용자가 로그인하지 않은 경우 로그인 페이지로 리다이렉트
      return const RouteSettings(name: '/login');
    }
    // 사용자가 로그인한 경우 원래 요청한 페이지로 이동
    return null;
  }
}