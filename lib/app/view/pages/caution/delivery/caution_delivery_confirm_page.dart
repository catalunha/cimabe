import 'package:cimabe/app/view/controllers/caution/delivery/caution_delivery_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_photo_show.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionDeliveryConfirmPage extends StatelessWidget {
  final _cautionDeliveryController = Get.find<CautionDeliveryController>();
  CautionDeliveryConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cautela de item - Confirmação')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextTitleValue(
                    title: 'Quantidade de itens: ',
                    value: _cautionDeliveryController.quantityEnd.toString(),
                  ),
                  const SizedBox(height: 15),
                  AppPhotoShow(
                    photoUrl:
                        _cautionDeliveryController.cautionModel!.item!.photo,
                    width: 300,
                    height: 100,
                  ),
                  const SizedBox(height: 15),
                  AppTextTitleValue(
                    title: 'Item: ',
                    value: _cautionDeliveryController
                        .cautionModel!.item!.description,
                  ),
                  AppTextTitleValue(
                    title: 'Grupos: ',
                    value: _cautionDeliveryController
                        .cautionModel!.item!.groups!
                        .join('\n'),
                    inColumn: true,
                  ),
                  const Divider(height: 5),
                  const SizedBox(height: 15),
                  AppPhotoShow(
                    photoUrl: _cautionDeliveryController
                        .cautionModel!.receiverUserProfile!.photo,
                    height: 100,
                    width: 100,
                  ),

                  const SizedBox(height: 15),
                  AppTextTitleValue(
                    title: 'Nome em tropa: ',
                    value: _cautionDeliveryController
                        .cautionModel!.receiverUserProfile!.nickname,
                    inColumn: true,
                  ),
                  AppTextTitleValue(
                    title: 'Restrições: ',
                    value: _cautionDeliveryController
                        .cautionModel!.receiverUserProfile!.restrictions!
                        .join('\n'),
                    inColumn: true,
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 5),
                  IconButton(
                    tooltip: 'Confirmar cautela.',
                    onPressed: () async {
                      await _cautionDeliveryController.confirmed();
                      Get.back();
                      Get.back();
                      // Get.toNamed(Routes.cautionDeliverySearch,
                      //     arguments: _cautionDeliveryController.registerEnd);
                    },
                    icon: const Icon(Icons.send),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // IconButton(
                  //   tooltip: 'Nova item, outro operador',
                  //   onPressed: () async {
                  //     await _cautionDeliveryController.confirmed();
                  //     Get.back();
                  //     Get.back();
                  //   },
                  //   icon: const Icon(Icons.keyboard_tab),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
