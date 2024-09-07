import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MateViewModel extends GetxController {
  late final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;


  /* -- update -- */
  void updateTapIndex(int newIndex) {
    _tabIndex.value = newIndex;
  }
}