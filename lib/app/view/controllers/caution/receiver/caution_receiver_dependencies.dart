import 'package:cimabe/app/data/b4a/table/caution/caution_repository_b4a.dart';
import 'package:cimabe/app/data/b4a/table/item/item_repository_b4a.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/view/controllers/caution/receiver/caution_receiver_controller.dart';
import 'package:get/get.dart';

class CautionReceiverDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CautionRepository>(
      () => CautionRepositoryB4a(),
    );
    Get.lazyPut<ItemRepository>(
      () => ItemRepositoryB4a(),
    );

    Get.put<CautionReceiverController>(
      CautionReceiverController(
        itemRepository: Get.find(),
        cautionRepository: Get.find(),
      ),
    );
  }
}