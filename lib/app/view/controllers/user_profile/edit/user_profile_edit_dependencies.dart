import 'package:cimabe/app/data/b4a/table/user_profile/user_profile_repository_b4a.dart';
import 'package:cimabe/app/data/repositories/profile_repository.dart';
import 'package:cimabe/app/view/controllers/user_profile/edit/user_profile_edit_controller.dart';
import 'package:get/get.dart';

class UserProfileEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileRepository>(
      () => UserProfileRepositoryB4a(),
    );

    Get.put<UserProfileEditController>(
      UserProfileEditController(
        userProfileRepository: Get.find(),
      ),
    );
  }
}
