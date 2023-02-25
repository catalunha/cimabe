import 'package:cimabe/app/core/models/image_model.dart';
import 'package:cimabe/app/data/b4a/table/image/image_repository_exception.dart';
import 'package:cimabe/app/data/repositories/image_repository.dart';
import 'package:cimabe/app/data/utils/pagination.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../data/b4a/entity/image_entity.dart';
import '../../../data/b4a/utils/xfile_to_parsefile.dart';
import '../../../routes.dart';

class ImageSearchAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final ImageRepository _imageRepository;

  ImageSearchAddEditController({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ImageModel> imageList = <ImageModel>[].obs;

  final _image = Rxn<ImageModel>();
  ImageModel? get image => _image.value;
  set image(ImageModel? imageNew) => _image(imageNew);

  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ImageEntity.className));

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  @override
  void onInit() {
    imageList.clear();
    _changePagination(1, 2);
    ever(_pagination, (_) async => await getMoreImage());
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

  Future<void> getMoreImage() async {
    if (!lastPage) {
      _loading(true);
      List<ImageModel> temp = await _imageRepository.list(
        query,
        _pagination.value,
      );
      if (temp.isEmpty) {
        _lastPage(true);
      }
      imageList.addAll(temp);
      _loading(false);
    }
  }

  Future<void> search({
    required String keywords,
  }) async {
    _loading(true);
    var keywordsList = keywords.split(' ');
    if (keywordsList.isNotEmpty) {
      query.whereContainedIn('keywords', keywordsList);
    }
    query.orderByDescending('updatedAt');

    imageList.clear();
    _lastPage(false);
    _pagination.update((val) {
      val!.page = 1;
      val.limit = 2;
    });
    _loading(false);
  }

  addImage() {
    image = null;
    Get.toNamed(Routes.imageAddEdit);
  }

  updateImage(ImageModel imageModel) {
    image = imageModel;
    Get.toNamed(Routes.imageAddEdit);
  }

  Future<void> addedit({
    String? keywords,
  }) async {
    try {
      _loading(true);
      if (image == null) {
        image = ImageModel(
          keywords: keywords?.split(' '),
        );
      } else {
        image = image!.copyWith(
          keywords: keywords?.split(' '),
        );
      }

      image = await _imageRepository.update(image!);
      if (_xfile != null) {
        String? imageUrl = await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: ImageEntity.className,
          objectId: image!.id!,
          objectAttribute: 'url',
        );
        image = image!.copyWith(url: imageUrl);
      }
      int index = imageList.indexWhere((model) => model.id == image!.id!);
      if (index > -1) {
        imageList.replaceRange(index, index + 1, [image!]);
      }
    } on ImageRepositoryException {
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
