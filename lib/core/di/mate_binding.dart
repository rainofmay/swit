import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/mate/data/datasources/mate_remote_data_source.dart';
import 'package:swit/features/mate/data/repsoitories/mate_repository_impl.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/mate/domain/usecases/follow_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_follower_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_following_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/search_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/unfollow_mate_use_case.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/user/presentation/viewmodel/user_view_model.dart';

class MateBinding extends Bindings {
  @override
  void dependencies() {
    /* -- LoginService -- */
    Get.lazyPut<LoginService>(() => LoginService());

    /* -- MateRemoteDataSource -- */
    Get.lazyPut<MateRemoteDataSource>(() => MateRemoteDataSource());

    /* -- MateRepository -- */
    Get.lazyPut<MateRepository>(() => MateRepositoryImpl(
          Get.find<MateRemoteDataSource>(),
          Get.find<LoginService>(),
        ));

    /* -- Use Case -- */
    Get.lazyPut<SearchMateUseCase>(
            () => SearchMateUseCase(Get.find<MateRepository>()));
    Get.lazyPut<GetFollowingListUseCase>(
            () => GetFollowingListUseCase(Get.find<MateRepository>()));
    Get.lazyPut<GetFollowerListUseCase>(
            () => GetFollowerListUseCase(Get.find<MateRepository>()));
    Get.lazyPut<FollowMateUseCase>(
            () => FollowMateUseCase(Get.find<MateRepository>()));
    Get.lazyPut<UnfollowMateUseCase>(
            () => UnfollowMateUseCase(Get.find<MateRepository>()));

    /* -- ViewModel -- */
    Get.lazyPut(() => MateViewModel(
        userViewModel: Get.find<UserViewModel>(),
        searchMateUseCase: Get.find<SearchMateUseCase>(),
        getFollowingListUseCase: Get.find<GetFollowingListUseCase>(),
        getFollowerListUseCase: Get.find<GetFollowerListUseCase>(),
        followMateUseCase: Get.find<FollowMateUseCase>(),
        unfollowMateUseCase: Get.find<UnfollowMateUseCase>(),
    ));

  }

  void dispose() {
    // ViewModel 제거
    Get.delete<MateViewModel>();

    // Use Case 제거
    Get.delete<SearchMateUseCase>();
    Get.delete<GetFollowingListUseCase>();
    Get.delete<GetFollowerListUseCase>();
    Get.delete<FollowMateUseCase>();
    Get.delete<UnfollowMateUseCase>();

    // Repository 제거
    Get.delete<MateRepository>();

    // DataSource 제거
    Get.delete<MateRemoteDataSource>();
  }
}
