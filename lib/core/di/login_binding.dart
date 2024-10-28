import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/user/data/datasources/google_login_remote_data_source.dart';
import 'package:swit/features/user/data/repositories/login_repository_impl.dart';
import 'package:swit/features/user/domain/repositories/login_repository.dart';
import 'package:swit/features/user/domain/usecases/google_login_use_case.dart';
import 'package:swit/features/user/presentation/viewmodel/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {

    /* -- DataSource -- */
    Get.lazyPut(() => GoogleLoginRemoteDataSource());

    /* -- Repository -- */
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(Get.find<GoogleLoginRemoteDataSource>()));

    /* -- Use Case -- */
    Get.lazyPut<GoogleLoginUseCase>(
        () => GoogleLoginUseCase(Get.find<LoginRepository>()));

    /* -- View Model -- */
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(
        googleLoginUseCase: Get.find<GoogleLoginUseCase>(),
        loginService: Get.find<LoginService>(),
    ));

  }
}
