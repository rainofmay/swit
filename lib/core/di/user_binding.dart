import 'package:get/get.dart';
import 'package:swit/features/user/data/datasources/user_remote_data_source.dart';
import 'package:swit/features/user/data/repositories/user_repository_impl.dart';
import 'package:swit/features/user/domain/repositories/user_repository.dart';
import 'package:swit/features/user/domain/usecases/update_my_profile_use_case.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {

    /* -- RemoteDataSource -- */
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSource());

    /* -- MateRepository -- */
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(
      Get.find<UserRemoteDataSource>(),
    ));

    /* -- Use Case -- */
    Get.lazyPut<UpdateMyProfileUseCase>(
            () => UpdateMyProfileUseCase(Get.find<UserRepository>()));

    /* -- ViewModel -- */
    Get.lazyPut(() => UserViewModel(
     updateMyProfileUseCase: Get.find<UpdateMyProfileUseCase>(),
    ));
  }
}
