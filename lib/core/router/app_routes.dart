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

  static const NOTIFICATION = '/study/notification';
  static const AUDIO = '/study/audio';
  static const SWIT = '/study/swit';
  static const CREATESWIT = '/study/swit/create';
  static const SWITSETTING = '/study/swit/setting';
  static const BACKGROUNDSETTING = '/study/setting/background';

  /* ------------------------------------------------------ */
  /* Record Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  static const RECORD = '/record';
  static const ADDRECORD = '/record/addrecord';
  static const TIMERECORD = '/record/addrecord/timerecord';
  static const ADDTASK = '/record/addrecord/addtask';
  static const EDITTASK = '/record/addrecord/edittask';

  /* ------------------------------------------------------ */
  /* Mate Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  static const MATE = '/mate';
  static const CREATEPOSTIT = '/mate/createpostit';
  static const ADDMATE = '/mate/addmate';
  static const EDITPROFILE = '/mate/editprofile';

  /* ------------------------------------------------------ */
  /* More Fields ------------------------------------------ */
  /* ------------------------------------------------------ */
  static const MORE = '/more';
  static const USERINFO = '/more/userinfo';
  static const LOGIN = '/login';
}

