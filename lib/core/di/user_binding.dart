import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/user/data/datasources/user_remote_data_source.dart';
import 'package:swit/features/user/data/repositories/user_repository_impl.dart';
import 'package:swit/features/user/domain/repositories/user_repository.dart';
import 'package:swit/features/user/domain/usecases/get_my_profile_use_case.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';

// 즉각 초기화를 위해 Put으로 통일
class UserBinding extends Bindings {
  @override
  void dependencies() {

    /* -- RemoteDataSource -- */
    Get.put<UserRemoteDataSource>(UserRemoteDataSource());

    /* -- MateRepository -- */
    Get.put<UserRepository>(UserRepositoryImpl(
      Get.find<UserRemoteDataSource>(),
      Get.find<LoginService>(),
    ));

    /* -- Use Case -- */
    Get.put<UpdateMyProfileUseCase>(
        UpdateMyProfileUseCase(Get.find<UserRepository>()));
    Get.put<GetMyProfileUseCase>(
        GetMyProfileUseCase(Get.find<UserRepository>()));

    /* -- ViewModel -- */
    Get.put(UserViewModel(
      getMyProfileUseCase: Get.find<GetMyProfileUseCase>(),
      updateMyProfileUseCase: Get.find<UpdateMyProfileUseCase>(),
      loginService: Get.find<LoginService>(),
    ));
  }
}