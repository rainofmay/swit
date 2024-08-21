import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum HomeTab{
  home(label : 'Home'),
  record(label : 'Record'),
  mate(label : 'Mate'),
  more(label : 'More');

  const HomeTab({required this.label});
  final String label;
}

// UI 관련 로직이지만 간단하여 extenstion 파일을 분리하지 않았음.
extension HomeTabX on HomeTab {
  String get onIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/home_black.svg';
      case HomeTab.record:
        return 'assets/icons/mate_black.svg';
      case HomeTab.mate:
        return 'assets/icons/mate_black.svg';
      case HomeTab.more:
        return 'assets/icons/more_black.svg';
    }
  }

  String get offIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/home_gray.svg';
      case HomeTab.record:
        return 'assets/icons/mate_gray.svg';
      case HomeTab.mate:
        return 'assets/icons/mate_gray.svg';
      case HomeTab.more:
        return 'assets/icons/more_gray.svg';
    }
  }
}