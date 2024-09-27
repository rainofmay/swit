import 'package:get/get.dart';
import 'package:swit/core/utils/user/login_service.dart';
import 'package:swit/features/mate/data/datasources/mate_remote_data_source.dart';
import 'package:swit/features/mate/data/repsoitories/mate_repository_impl.dart';
import 'package:swit/features/mate/domain/repositories/mate_repository.dart';
import 'package:swit/features/mate/domain/usecases/follow_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_following_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_mates_list_use_case.dart';
import 'package:swit/features/mate/domain/usecases/get_user_profile_use_case.dart';
import 'package:swit/features/mate/domain/usecases/search_mate_use_case.dart';
import 'package:swit/features/mate/domain/usecases/unfollow_mate_use_case.dart';
import 'package:swit/features/mate/presentation/viewmodel/mate_view_model.dart';
import 'package:swit/features/mate/presentation/viewmodel/post_tab_view_model.dart';

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
    Get.lazyPut<GetUserProfileUseCase>(
        () => GetUserProfileUseCase(Get.find<MateRepository>()));
    Get.lazyPut<GetMatesListUseCase>(
        () => GetMatesListUseCase(Get.find<MateRepository>()));
    Get.lazyPut<SearchMateUseCase>(
            () => SearchMateUseCase(Get.find<MateRepository>()));
    Get.lazyPut<GetFollowingListUseCase>(
            () => GetFollowingListUseCase(Get.find<MateRepository>()));
    Get.lazyPut<FollowMateUseCase>(
            () => FollowMateUseCase(Get.find<MateRepository>()));
    Get.lazyPut<UnfollowMateUseCase>(
            () => UnfollowMateUseCase(Get.find<MateRepository>()));

    /* -- ViewModel -- */
    Get.lazyPut(() => MateViewModel(
        getUserProfileUseCase: Get.find<GetUserProfileUseCase>(),
        getMatesListUseCase: Get.find<GetMatesListUseCase>(),
        searchMateUseCase: Get.find<SearchMateUseCase>(),
        getFollowingListUseCase: Get.find<GetFollowingListUseCase>(),
        followMateUseCase: Get.find<FollowMateUseCase>(),
        unfollowMateUseCase: Get.find<UnfollowMateUseCase>(),
    ));

    Get.lazyPut(() => PostTabViewModel(mateViewModel : Get.find<MateViewModel>()));
  }
}
