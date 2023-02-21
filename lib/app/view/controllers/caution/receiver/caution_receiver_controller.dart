import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/data/b4a/entity/caution_entity.dart';
import 'package:cimabe/app/data/b4a/entity/user_profile_entity.dart';
import 'package:cimabe/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
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
    // getCurrentCautions();
    super.onInit();
  }

  Future<void> getCurrentCautions() async {
    cautionList.clear();
    // _loading(true);
    var splashController = Get.find<SplashController>();
    UserProfileModel userProfileReceiver =
        splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'userProfileDeliver',
      'userProfileReceiver',
      'userProfileGiveback',
      'item'
    ]);
    query.whereEqualTo(
        'userProfileReceiver',
        (ParseObject(UserProfileEntity.className)
              ..objectId = userProfileReceiver.id)
            .toPointer());
    query.whereEqualTo('givebackAnalyzingItem', null);
    query.whereEqualTo('receiverIsPermanentItem', false);
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  Future<void> getPermanentCautions() async {
    cautionList.clear();
    // _loading(true);
    var splashController = Get.find<SplashController>();
    UserProfileModel userProfileReceiver =
        splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'userProfileDeliver',
      'userProfileReceiver',
      'userProfileGiveback',
      'item'
    ]);
    query.whereEqualTo(
        'userProfileReceiver',
        (ParseObject(UserProfileEntity.className)
              ..objectId = userProfileReceiver.id)
            .toPointer());
    query.whereEqualTo('givebackAnalyzingItem', null);
    query.whereEqualTo('receiverIsPermanentItem', true);
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  Future<void> getHistoryCautions() async {
    cautionList.clear();
    // _loading(true);
    var splashController = Get.find<SplashController>();
    UserProfileModel userProfileReceiver =
        splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'userProfileDeliver',
      'userProfileReceiver',
      'userProfileGiveback',
      'item'
    ]);
    query.whereEqualTo(
        'userProfileReceiver',
        (ParseObject(UserProfileEntity.className)
              ..objectId = userProfileReceiver.id)
            .toPointer());
    // query.whereEqualTo('receiverStartGiveback', true);
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  Future<void> updateReceiverAnalyzingItemWithRefused(
      CautionModel cautionModel) async {
    try {
      // _loading(true);
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;

      cautionModelTemp = cautionModel.copyWith(
        receiverAnalyzingItem: false,
        receiverAnalyzedItemDt: datetime,
        receiverStartGiveback: true,
        receiverGivebackItemDt: datetime,
      );

      await _cautionRepository.update(cautionModelTemp);
      getCurrentCautions();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  Future<void> updateReceiverAnalyzingItemWithAccepted(
      CautionModel cautionModel) async {
    try {
      // _loading(true);
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;
      cautionModelTemp = cautionModel.copyWith(
        receiverAnalyzingItem: true,
        receiverAnalyzedItemDt: datetime,
        receiverStartGiveback: false,
      );

      await _cautionRepository.update(cautionModelTemp);
      getCurrentCautions();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  Future<void> updateReceiverStartGiveback(
      CautionModel cautionModel, String description) async {
    try {
      // _loading(true);
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;
      cautionModelTemp = cautionModel.copyWith(
        receiverStartGiveback: true,
        receiverGivebackItemDt: datetime,
        receiverGivebackDescription: description,
      );

      await _cautionRepository.update(cautionModelTemp);
      getCurrentCautions();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  Future<void> updateReceiverIsPermanentItem(
      CautionModel cautionModel, bool value) async {
    try {
      // _loading(true);
      CautionModel cautionModelTemp;
      cautionModelTemp = cautionModel.copyWith(
        receiverIsPermanentItem: value,
      );

      await _cautionRepository.update(cautionModelTemp);
      Get.back();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }
}
