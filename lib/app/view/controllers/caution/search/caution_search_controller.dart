import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/data/b4a/entity/caution_entity.dart';
import 'package:cimabe/app/data/repositories/caution_repository.dart';
import 'package:cimabe/app/data/utils/pagination.dart';
import 'package:cimabe/app/routes.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final CautionRepository _itemRepository;
  CautionSearchController({
    required CautionRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<CautionModel> cautionList = <CautionModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));

  @override
  void onInit() {
    cautionList.clear();
    _changePagination(1, 2);
    ever(_pagination, (_) async => await getMoreData());
    loaderListener(_loading);
    messageListener(_message);

    super.onInit();
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  Future<void> search({
    required bool deliveryDtSelected,
    required DateTime deliveryDtValue,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'deliveryUserProfile',
      'receiverUserProfile',
      'givebackUserProfile',
      'item'
    ]);
    if (deliveryDtSelected) {
      query.whereGreaterThanOrEqualsTo(
          'deliveryDt',
          DateTime(deliveryDtValue.year, deliveryDtValue.month,
              deliveryDtValue.day));
      query.whereLessThanOrEqualTo(
          'deliveryDt',
          DateTime(deliveryDtValue.year, deliveryDtValue.month,
              deliveryDtValue.day, 23, 59));
    }
    cautionList.clear();
    // if (lastPage) {
    _lastPage(false);
    _pagination.update((val) {
      val!.page = 1;
      val.limit = 2;
    });
    // }
    // await getMoreData();

    // _changePagination(_pagination.value.page, _pagination.value.limit);
    _loading(false);
    Get.toNamed(Routes.cautionSearchList);
  }

  Future<void> getMoreData() async {
    if (!lastPage) {
      _loading(true);
      List<CautionModel> temp = await _itemRepository.list(
        query,
        _pagination.value,
      );
      if (temp.isEmpty) {
        _lastPage(true);
      }
      cautionList.addAll(temp);
      _loading(false);
    }
  }
}
