import 'package:cimabe/app/data/b4a/table/caution/caution_repository_b4a.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/view/controllers/caution/search/caution_search_controller.dart';
import 'package:get/get.dart';

class CautionSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CautionRepository>(
      () => CautionRepositoryB4a(),
    );

    Get.put<CautionSearchController>(
      CautionSearchController(
        itemRepository: Get.find(),
      ),
    );
  }
}
