import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/supabase_service.dart';

abstract class BaseRemoteDataSource {
  final SupabaseClient supabase = Get.find<SupabaseService>().client;
}