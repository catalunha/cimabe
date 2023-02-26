import 'package:cimabe/app/core/models/image_model.dart';
import 'package:cimabe/app/view/controllers/image/image_search_addedit_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_icon.dart';
import '../utils/app_photo_show.dart';
import '../utils/app_text_title_value.dart';

class ImageSearchPage extends StatefulWidget {
  final _imageSearchAddEditController =
      Get.find<ImageSearchAddEditController>();
  ImageSearchPage({super.key});

  @override
  State<ImageSearchPage> createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _keywordsTEC = TextEditingController();

  @override
  void initState() {
    _keywordsTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar images'),
        actions: [
          IconButton(
            onPressed: () {
              // Get.to(() => ImagePrintPage());
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    label: 'Informe palavra(s) chave',
                    controller: _keywordsTEC,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await widget._imageSearchAddEditController
                          .search(keywords: _keywordsTEC.text);
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              widget._imageSearchAddEditController.nextPage();
            },
            child: Obx(() => Container(
                  color: widget._imageSearchAddEditController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: widget._imageSearchAddEditController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Obx(
                  () => ListView.builder(
                    itemCount:
                        widget._imageSearchAddEditController.imageList.length,
                    itemBuilder: (context, index) {
                      final item =
                          widget._imageSearchAddEditController.imageList[index];
                      return ImageCard(
                        imageModel: item,
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Inserir nova imagem',
        child: const Icon(AppIconData.addInCloud),
        onPressed: () => widget._imageSearchAddEditController.addImage(),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final _imageSearchAddEditController =
      Get.find<ImageSearchAddEditController>();
  final ImageModel imageModel;
  ImageCard({Key? key, required this.imageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AppPhotoShow(
            photoUrl: imageModel.url,
            width: 300,
            height: 100,
          ),
          AppTextTitleValue(
            title: 'Id: ',
            value: imageModel.id,
          ),
          Text('${imageModel.keywords?.join(' ')}'),
          Wrap(
            children: [
              IconButton(
                onPressed: () =>
                    _imageSearchAddEditController.updateImage(imageModel),
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
