import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/data/b4a/entity/item_entity.dart';
import 'package:cimabe/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimabe/app/data/b4a/utils/xfile_to_parsefile.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  ItemAddEditController({
    required ItemRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _item = Rxn<ItemModel>();
  ItemModel? get item => _item.value;
  set item(ItemModel? itemNew) => _item(itemNew);

  String? itemId;

// //+++ forms
//   final descriptionTec = TextEditingController();
//   final serieTec = TextEditingController();
//   final lote = TextEditingController();
//   final brandTec = TextEditingController();
//   final modelTec = TextEditingController();
//   final calibreTec = TextEditingController();
//   final docTec = TextEditingController();
//   final obsCautionTec = TextEditingController();
//   bool isMunition = false;
//   bool isBlockedOperator = false;
//   bool isBlockedDoc = false;
//   final groupsTec = TextEditingController();
// //--- forms
  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  final Rxn<DateTime> _validate = Rxn<DateTime>();
  DateTime? get validate => _validate.value;
  set validate(DateTime? selectedDate) {
    if (selectedDate != null) {
      _validate.value = DateTime(selectedDate.year, selectedDate.month);
    }
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    item = Get.arguments;
    super.onInit();
  }

  Future<void> addedit({
    String? description,
    String? serie,
    String? lote,
    String? brand,
    String? model,
    String? calibre,
    String? doc,
    String? obsCaution,
    bool? isMunition,
    bool? isBlockedOperator,
    bool? isBlockedDoc,
    String? groups,
  }) async {
    try {
      _loading(true);
      if (item == null) {
        item = ItemModel(
          description: description,
          serie: serie,
          lote: lote,
          brand: brand,
          model: model,
          calibre: calibre,
          doc: doc,
          obsCaution: obsCaution,
          validate: validate,
          isMunition: isMunition,
          isBlockedOperator: isBlockedOperator,
          isBlockedDoc: isBlockedDoc,
          groups: groups?.split('\n'),
        );
      } else {
        item = item!.copyWith(
          description: description,
          serie: serie,
          lote: lote,
          brand: brand,
          model: model,
          calibre: calibre,
          doc: doc,
          obsCaution: obsCaution,
          validate: validate,
          isMunition: isMunition,
          isBlockedOperator: isBlockedOperator,
          isBlockedDoc: isBlockedDoc,
          groups: groups?.split('\n'),
        );
      }
      String itemId = await _itemRepository.update(item!);
      if (_xfile != null) {
        String? photoUrl = await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: ItemEntity.className,
          objectId: itemId,
          objectAttribute: 'photo',
        );
      }
    } on ItemRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
