part of 'app_pages.dart';

abstract class Routes {
  static const HOME = '/';

  /* ------------------------------------------------------ */
  /* Study Fields ----------------------------------------- */
  /* ------------------------------------------------------ */
  static const STUDY = '/study';
  static const SCHEDULE = '/study/schedule';
  static const CREATESCHEDULE = '/study/schedule/create';
  static const EDITSCHEDULE = '/study/schedule/edit';
  static const AUDIO = '/study/audio';
  static const SWIT = '/study/swit';
  static const SWITSETTING = '/study/swit/setting';
  static const BACKGROUNDSETTING = '/study/setting/background';

  /* ------------------------------------------------------ */
  /* Record Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  static const RECORD = '/record';
  static const RECORDADD = '/record/recordadd';
  static const ADDTASK = '/record/addtask';
  static const EDITTASK = '/record/edittask';
  /* ------------------------------------------------------ */
  /* Mate Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  static const MATE = '/mate';
  static const CREATEPOSTIT = '/mate/createpostit';
  static const MATEADD = '/mate/mateadd';

  /* ------------------------------------------------------ */
  /* More Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  static const MORE = '/more';
  static const USERINFO = '/more/userinfo';
  static const LOGIN = '/login';
}

