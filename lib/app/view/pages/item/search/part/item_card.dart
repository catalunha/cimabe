import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/routes.dart';
import 'package:cimabe/app/view/pages/utils/app_photo_show.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  final ItemModel itemModel;
  const ItemCard({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AppPhotoShow(
            photoUrl: itemModel.photo,
            width: 300,
            height: 100,
          ),
          AppTextTitleValue(
            title: 'Id: ',
            value: itemModel.id,
          ),
          AppTextTitleValue(
            title: 'Descrição: ',
            value: itemModel.description,
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.itemAddEdit, arguments: itemModel);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.userProfileView,
                    arguments: itemModel.id,
                  );
                },
                icon: const Icon(
                  Icons.assignment_ind_outlined,
                ),
              ),
              IconButton(
                onPressed: () => copy(itemModel.id!),
                icon: const Icon(
                  Icons.copy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(text, 'Id copiado.',
        margin: const EdgeInsets.all(10), duration: const Duration(seconds: 1));
    await Clipboard.setData(ClipboardData(text: text));
  }
}
