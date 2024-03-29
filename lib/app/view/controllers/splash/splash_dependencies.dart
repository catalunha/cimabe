import 'package:cimabe/app/data/b4a/table/user/user_repository_b4a.dart';
import 'package:cimabe/app/data/repositories/user_repository.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryB4a(),
    );

    Get.put<SplashController>(
      SplashController(
        userRepository: Get.find(),
      ),
      permanent: true,
    );
  }
}
