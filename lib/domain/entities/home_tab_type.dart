import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum HomeTab{
  home(label : 'Home'),
  mate(label : 'Mate'),
  bookmark(label : 'Bookmark'),
  more(label : 'More');

  const HomeTab({required this.label});
  final String label;
}

// UI 관련 로직이지만 간단하여 extenstion 파일을 분리하지 않았음.
extension HomeTabX on HomeTab {
  String get onIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/my_icon.svg';
      case HomeTab.mate:
        return 'assets/icons/my_icon.svg';
      case HomeTab.bookmark:
        return 'assets/icons/my_icon.svg';
      case HomeTab.more:
        return 'assets/icons/my_icon.svg';
    }
  }

  String get offIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/my_icon.svg';
      case HomeTab.mate:
        return 'assets/icons/my_icon.svg';
      case HomeTab.bookmark:
        return 'assets/icons/my_icon.svg';
      case HomeTab.more:
        return 'assets/icons/my_icon.svg';
    }
  }
}