import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/data/b4a/entity/caution_entity.dart';
import 'package:cimabe/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionGivebackController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  final CautionRepository _cautionRepository;
  CautionGivebackController({
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
    // var splashController = Get.find<SplashController>();
    // UserProfileModel userProfileGiveback =
    //     splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'userProfileDeliver',
      'userProfileReceiver',
      'userProfileGiveback',
      'item'
    ]);
    // query.whereEqualTo(
    //     'userProfileGiveback',
    //     (ParseObject(UserProfileEntity.className)
    //           ..objectId = userProfileGiveback.id)
    //         .toPointer());
    query.whereEqualTo('receiverStartGiveback', true);
    query.whereEqualTo('givebackAnalyzingItem', null);
    // query.whereNotEqualTo('givebackAnalyzingItem', true);
    // query.whereNotEqualTo('givebackAnalyzingItem', false);
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  // Future<void> getPermanentCautions() async {
  //   cautionList.clear();
  //   // _loading(true);
  //   var splashController = Get.find<SplashController>();
  //   UserProfileModel userProfileGiveback =
  //       splashController.userModel!.userProfile!;
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
  //   query.includeObject(['userProfileDeliver', 'userProfileGiveback', 'item']);
  //   query.whereEqualTo(
  //       'userProfileGiveback',
  //       (ParseObject(UserProfileEntity.className)
  //             ..objectId = userProfileGiveback.id)
  //           .toPointer());
  //   query.whereNotEqualTo('givebackAnalyzingItem', true);
  //   query.whereNotEqualTo('givebackAnalyzingItem', false);
  //   query.whereEqualTo('receiverIsPermanentItem', true);
  //   List<CautionModel> temp = await _cautionRepository.list(query, null);
  //   cautionList.addAll(temp);
  //   // _loading(false);
  // }

  // Future<void> getHistoryCautions() async {
  //   cautionList.clear();
  //   // _loading(true);
  //   var splashController = Get.find<SplashController>();
  //   UserProfileModel userProfileGiveback =
  //       splashController.userModel!.userProfile!;
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
  //   query.includeObject(['userProfileDeliver', 'userProfileGiveback', 'item']);
  //   query.whereEqualTo(
  //       'userProfileGiveback',
  //       (ParseObject(UserProfileEntity.className)
  //             ..objectId = userProfileGiveback.id)
  //           .toPointer());
  //   // query.whereEqualTo('receiverStartGiveback', true);
  //   List<CautionModel> temp = await _cautionRepository.list(query, null);
  //   cautionList.addAll(temp);
  //   // _loading(false);
  // }

  Future<void> updateGivebackAnalyzingItemWithRefused(
      CautionModel cautionModel, String description) async {
    try {
      // _loading(true);
      var splashController = Get.find<SplashController>();
      UserProfileModel userProfileGiveback =
          splashController.userModel!.userProfile!;
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;

      cautionModelTemp = cautionModel.copyWith(
        userProfileGiveback: userProfileGiveback,
        givebackAnalyzingItem: false,
        givebackAnalyzedItemDt: datetime,
        givebackAnalysisDescription: description,
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

  Future<void> updateGivebackAnalyzingItemWithAccepted(
      CautionModel cautionModel) async {
    try {
      // _loading(true);
      var splashController = Get.find<SplashController>();
      UserProfileModel userProfileGiveback =
          splashController.userModel!.userProfile!;
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;

      cautionModelTemp = cautionModel.copyWith(
        userProfileGiveback: userProfileGiveback,
        givebackAnalyzingItem: true,
        givebackAnalyzedItemDt: datetime,
        givebackAnalysisDescription: 'Devolvido sem obs.',
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

  // Future<void> updateGivebackStartGiveback(
  //     CautionModel cautionModel, String description) async {
  //   try {
  //     // _loading(true);
  //     DateTime now = DateTime.now();
  //     DateTime datetime =
  //         DateTime(now.year, now.month, now.day, now.hour, now.minute);
  //     CautionModel cautionModelTemp;
  //     cautionModelTemp = cautionModel.copyWith(
  //       receiverStartGiveback: true,
  //       receiverGivebackItemDt: datetime,
  //       receiverGivebackDescription: description,
  //     );

  //     await _cautionRepository.update(cautionModelTemp);
  //     getCurrentCautions();
  //   } on CautionRepositoryException {
  //     // _loading(false);
  //     _message.value = MessageModel(
  //       title: 'Erro em CautionDeliveryController',
  //       message: 'Não foi possivel salvar em Caution',
  //       isError: true,
  //     );
  //   } finally {
  //     // _loading(false);
  //   }
  // }

  // Future<void> updateGivebackIsPermanentItem(
  //     CautionModel cautionModel, bool value) async {
  //   try {
  //     // _loading(true);
  //     CautionModel cautionModelTemp;
  //     cautionModelTemp = cautionModel.copyWith(
  //       receiverIsPermanentItem: value,
  //     );

  //     await _cautionRepository.update(cautionModelTemp);
  //     Get.back();
  //   } on CautionRepositoryException {
  //     // _loading(false);
  //     _message.value = MessageModel(
  //       title: 'Erro em CautionDeliveryController',
  //       message: 'Não foi possivel salvar em Caution',
  //       isError: true,
  //     );
  //   } finally {
  //     // _loading(false);
  //   }
  // }
}
