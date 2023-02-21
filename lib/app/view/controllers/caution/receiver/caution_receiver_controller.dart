import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/data/b4a/entity/caution_entity.dart';
import 'package:cimabe/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionReceiverController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  final CautionRepository _cautionRepository;
  CautionReceiverController({
    required ItemRepository itemRepository,
    required CautionRepository cautionRepository,
  })  : _itemRepository = itemRepository,
        _cautionRepository = cautionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<CautionModel> cautionList = <CautionModel>[].obs;

  final _cautionModel = Rxn<CautionModel>();
  CautionModel? get cautionModel => _cautionModel.value;
  set cautionModel(CautionModel? profileModelNew) =>
      _cautionModel(profileModelNew);

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    getCurrentCautions();
    super.onInit();
  }

  Future<void> getCurrentCautions() async {
    cautionList.clear();
    // _loading(true);
    // var splashController = Get.find<SplashController>();
    // UserProfileModel userProfileReceiver =
    //     splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject(['userProfileDeliver', 'userProfileReceiver', 'item']);
    // query.whereEqualTo(
    //     'userProfileReceiver',
    //     (ParseObject(UserProfileEntity.className)
    //           ..objectId = userProfileReceiver.id)
    //         .toPointer());
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  Future<void> updateReceiverAnalyzingItem(
      CautionModel cautionModel, bool value) async {
    try {
      _loading(true);
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);

      CautionModel cautionModelTemp = cautionModel.copyWith(
        receiverAnalyzingItem: value,
        receiverAnalyzedItemDt: datetime,
      );
      await _cautionRepository.update(cautionModelTemp);
      getCurrentCautions();
    } on CautionRepositoryException {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
