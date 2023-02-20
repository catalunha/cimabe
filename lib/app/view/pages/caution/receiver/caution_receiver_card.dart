import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/view/pages/utils/app_photo_show.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CautionReceiverCard extends StatelessWidget {
  final CautionModel cautionModel;
  const CautionReceiverCard({Key? key, required this.cautionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y hh:mm');
    return Card(
      child: Column(
        children: [
          AppTextTitleValue(
            title: 'Id: ',
            value: cautionModel.id,
          ),
          AppPhotoShow(
            photoUrl: cautionModel.item!.photo,
            width: 300,
            height: 100,
          ),
          AppTextTitleValue(
            title: 'Item: ',
            value: cautionModel.item!.description,
          ),
          AppTextTitleValue(
            title: 'Recebido em: ',
            value: dateFormat.format(cautionModel.deliverDt!),
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () {
                  // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Get.toNamed(
                  //   Routes.userProfileView,
                  //   arguments: cautionModel.id,
                  // );
                },
                icon: const Icon(
                  Icons.assignment_ind_outlined,
                ),
              ),
              IconButton(
                onPressed: () => copy(cautionModel.id!),
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
