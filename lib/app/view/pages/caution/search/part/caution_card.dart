import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/view/pages/utils/app_photo_show.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CautionCard extends StatelessWidget {
  final CautionModel cautionModel;
  const CautionCard({Key? key, required this.cautionModel}) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppPhotoShow(
                photoUrl: cautionModel.userProfileDeliver?.photo,
                height: 125,
                // width: 150,
              ),
              AppPhotoShow(
                photoUrl: cautionModel.userProfileReceiver?.photo,
                height: 125,
                // width: 150,
              ),
              // if (cautionModel.userProfileGiveback != null)
              AppPhotoShow(
                photoUrl: cautionModel.userProfileGiveback?.photo,
                height: 125,
                // width: 150,
              ),
            ],
          ),
          AppPhotoShow(
            photoUrl: cautionModel.item!.photo,
            height: 100,
            width: 300,
          ),
          AppTextTitleValue(
            title: 'Item: ',
            value: cautionModel.item!.description,
          ),
          AppTextTitleValue(
            title: 'Entregue por: ',
            value: cautionModel.userProfileDeliver!.nickname!,
          ),
          AppTextTitleValue(
            title: 'Entregue em: ',
            value: dateFormat.format(cautionModel.deliverDt!),
          ),
          AppTextTitleValue(
            title: 'Cautelado a: ',
            value: cautionModel.userProfileReceiver!.nickname!,
          ),
          AppTextTitleValue(
            title: 'Situação da análise ? ',
            value: cautionModel.receiverAnalyzingItem == null
                ? 'Analisando'
                : cautionModel.receiverAnalyzingItem == true
                    ? 'Aceito'
                    : 'Recusado',
          ),
          AppTextTitleValue(
            title: 'Analisado em: ',
            value: cautionModel.receiverAnalyzedItemDt == null
                ? '...'
                : dateFormat.format(cautionModel.receiverAnalyzedItemDt!),
          ),
          AppTextTitleValue(
            title: 'Em item permanente ? ',
            value:
                cautionModel.receiverIsPermanentItem == false ? 'Não' : 'Sim',
          ),
          AppTextTitleValue(
            title: 'Situação da devolução ? ',
            value: cautionModel.receiverStartGiveback == null
                ? 'Analisando'
                : cautionModel.receiverStartGiveback == false
                    ? 'Nao devolver. Em uso.'
                    : 'Devolução iniciada',
          ),
          AppTextTitleValue(
            title: 'Devolvido em: ',
            value: cautionModel.receiverGivebackItemDt == null
                ? '...'
                : dateFormat.format(cautionModel.receiverGivebackItemDt!),
          ),
          AppTextTitleValue(
            title: 'Descrição da devolução: ',
            value: cautionModel.receiverGivebackDescription,
            inColumn: true,
          ),
          AppTextTitleValue(
            title: 'Recebido por: ',
            value: cautionModel.userProfileGiveback?.nickname,
          ),
          AppTextTitleValue(
            title: 'Situação da recebimento ? ',
            value: cautionModel.receiverStartGiveback != true
                ? '...'
                : cautionModel.givebackAnalyzingItem == null
                    ? 'Analisando'
                    : cautionModel.givebackAnalyzingItem == false
                        ? 'Com observações.'
                        : 'Normal',
          ),
          AppTextTitleValue(
            title: 'Recebido em: ',
            value: cautionModel.givebackAnalyzedItemDt == null
                ? '...'
                : dateFormat.format(cautionModel.givebackAnalyzedItemDt!),
          ),
          AppTextTitleValue(
            title: 'Descrição do recebimento: ',
            value: cautionModel.givebackAnalysisDescription,
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
