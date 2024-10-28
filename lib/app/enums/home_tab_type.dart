
enum HomeTab{
  home(label : '홈'),
  mate(label : '메이트'),
  record(label : '기 록'),
  more(label : '더보기');

  const HomeTab({required this.label});
  final String label;
}

// UI 관련 로직이지만 간단하여 extenstion 파일을 분리하지 않았음.
extension HomeTabX on HomeTab {
  String get onIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/home_black.svg';
      case HomeTab.mate:
        return 'assets/icons/mate_black.svg';
      case HomeTab.record:
        return 'assets/icons/log_black.svg';
      case HomeTab.more:
        return 'assets/icons/more_black.svg';
    }
  }
  // String get onIcon {
  //   switch (this) {
  //     case HomeTab.home:
  //       return 'assets/icons/bottombar/home_color.svg';
  //     case HomeTab.mate:
  //       return 'assets/icons/bottombar/mate_color.svg';
  //     case HomeTab.record:
  //       return 'assets/icons/bottombar/log_color.svg';
  //     case HomeTab.more:
  //       return 'assets/icons/bottombar/more_color.svg';
  //   }
  // }

  String get offIcon {
    switch (this) {
      case HomeTab.home:
        return 'assets/icons/home_gray.svg';
      case HomeTab.mate:
        return 'assets/icons/mate_gray.svg';
      case HomeTab.record:
        return 'assets/icons/log_gray.svg';
      case HomeTab.more:
        return 'assets/icons/more_gray.svg';
    }
  }
}