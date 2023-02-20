import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/data/repositories/user_profile_repository.dart';
import 'package:cimabe/app/routes.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class CautionDeliveryController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  final ItemRepository _itemRepository;
  final CautionRepository _cautionRepository;
  CautionDeliveryController({
    required UserProfileRepository userProfileRepository,
    required ItemRepository itemRepository,
    required CautionRepository cautionRepository,
  })  : _userProfileRepository = userProfileRepository,
        _itemRepository = itemRepository,
        _cautionRepository = cautionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _cautionModel = Rxn<CautionModel>();
  CautionModel? get cautionModel => _cautionModel.value;
  set cautionModel(CautionModel? profileModelNew) =>
      _cautionModel(profileModelNew);
  int quantityEnd = 1;
  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> add({
    String? serie,
    String? lote,
    String? register,
    int quantity = 1,
  }) async {
    try {
      _loading(true);
      quantityEnd = quantity;
      var splashController = Get.find<SplashController>();
      UserProfileModel userProfileDeliver =
          splashController.userModel!.userProfile!;

      DateTime now = DateTime.now();
      DateTime deliverDt =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);

      ItemModel? itemmodel;
      if (serie != null && serie.isNotEmpty) {
        itemmodel = await _itemRepository.getBySerie(serie);
      } else if (lote != null && lote.isNotEmpty) {
        itemmodel = await _itemRepository.getByLote(lote);
      }
      if (itemmodel == null) {
        _loading(false);
        _message.value = MessageModel(
          title: 'Erro em Item',
          message: 'Não foi possível encontrar um item',
          isError: true,
        );
      } else {
        UserProfileModel? userProfileReceiver;
        userProfileReceiver =
            await _userProfileRepository.getByRegister(register);
        if (userProfileReceiver == null) {
          _loading(false);
          _message.value = MessageModel(
            title: 'Erro em Operador',
            message: 'Não foi possível encontrar um operador',
            isError: true,
          );
        } else {
          cautionModel = CautionModel(
            userProfileDeliver: userProfileDeliver,
            deliverDt: deliverDt,
            item: itemmodel,
            userProfileReceiver: userProfileReceiver,
          );
          _loading(false);
          Get.toNamed(Routes.cautionDeliveryConfirm);
        }
      }
    } on ItemRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  Future<bool> confirmed() async {
    try {
      _loading(true);
      for (var i = 0; i < quantityEnd; i++) {
        await _cautionRepository.update(cautionModel!);
      }
      return true;
    } on ItemRepositoryException {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
      return false;
    } finally {
      _loading(false);
    }
  }
}
