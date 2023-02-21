import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/view/pages/utils/app_photo_show.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CautionReceiverHistoryCard extends StatefulWidget {
  // final _cautionReceiverController = Get.find<CautionReceiverController>();
  final CautionModel cautionModel;
  const CautionReceiverHistoryCard({Key? key, required this.cautionModel})
      : super(key: key);

  @override
  State<CautionReceiverHistoryCard> createState() =>
      _CautionReceiverHistoryCardState();
}

class _CautionReceiverHistoryCardState
    extends State<CautionReceiverHistoryCard> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y hh:mm');
    return Card(
      child: Column(
        children: [
          AppTextTitleValue(
            title: 'Id: ',
            value: widget.cautionModel.id,
          ),
          AppPhotoShow(
            photoUrl: widget.cautionModel.item!.photo,
            width: 300,
            height: 100,
          ),
          AppTextTitleValue(
            title: 'Item: ',
            value: widget.cautionModel.item!.description,
          ),
          AppTextTitleValue(
            title: 'Entregue por: ',
            value: widget.cautionModel.userProfileDeliver!.nickname!,
          ),
          AppTextTitleValue(
            title: 'Entregue em: ',
            value: dateFormat.format(widget.cautionModel.deliverDt!),
          ),
          AppTextTitleValue(
            title: 'Situação da análise ? ',
            value: widget.cautionModel.receiverAnalyzingItem == null
                ? 'Analisando'
                : widget.cautionModel.receiverAnalyzingItem == true
                    ? 'Aceito'
                    : 'Recusado',
          ),
          AppTextTitleValue(
            title: 'Analisado em: ',
            value: widget.cautionModel.receiverAnalyzedItemDt == null
                ? '...'
                : dateFormat
                    .format(widget.cautionModel.receiverAnalyzedItemDt!),
          ),
          AppTextTitleValue(
            title: 'Em item permanente ? ',
            value: widget.cautionModel.receiverIsPermanentItem == false
                ? 'Não'
                : 'Sim',
          ),
          AppTextTitleValue(
            title: 'Situação da devolução ? ',
            value: widget.cautionModel.receiverStartGiveback == null
                ? 'Analisando'
                : widget.cautionModel.receiverStartGiveback == false
                    ? 'Nao devolver. Em uso.'
                    : 'Iniciar devolução',
          ),
          AppTextTitleValue(
            title: 'Devolvido em: ',
            value: widget.cautionModel.receiverGivebackItemDt == null
                ? '...'
                : dateFormat
                    .format(widget.cautionModel.receiverGivebackItemDt!),
          ),
          AppTextTitleValue(
            title: 'Descrição da devolução: ',
            value: widget.cautionModel.receiverGivebackDescription,
          ),
          AppTextTitleValue(
            title: 'Recebido por: ',
            value: widget.cautionModel.userProfileGiveback?.nickname,
          ),
          AppTextTitleValue(
            title: 'Situação da recebimento ? ',
            value: widget.cautionModel.receiverStartGiveback != true
                ? '...'
                : widget.cautionModel.givebackAnalyzingItem == null
                    ? 'Analisando'
                    : widget.cautionModel.givebackAnalyzingItem == false
                        ? 'Com observações.'
                        : 'Normal',
          ),
          AppTextTitleValue(
            title: 'Recebido em: ',
            value: widget.cautionModel.givebackAnalyzedItemDt == null
                ? '...'
                : dateFormat
                    .format(widget.cautionModel.givebackAnalyzedItemDt!),
          ),
          AppTextTitleValue(
            title: 'Descrição do recebimento: ',
            value: widget.cautionModel.givebackAnalysisDescription,
          ),
          // Wrap(
          //   children: [
          //     if (widget.cautionModel.receiverAnalyzingItem == null)
          //       IconButton(
          //         onPressed: () async {
          //           await widget._cautionReceiverController
          //               .updateReceiverAnalyzingItemWithRefused(
          //                   widget.cautionModel);
          //           String? res = await showDialog(
          //             barrierDismissible: false,
          //             context: context,
          //             builder: (BuildContext context) {
          //               return const DialogDescription(
          //                 title: 'Descrição',
          //                 formFieldLabel: '',
          //               );
          //             },
          //           );
          //           if (res != null) {
          //             widget._cautionReceiverController
          //                 .updateReceiverStartGiveback(
          //                     widget.cautionModel, res);
          //           }
          //           // setState(() {});
          //         },
          //         icon: const Icon(
          //           Icons.not_interested,
          //         ),
          //       ),
          //     if (widget.cautionModel.receiverAnalyzingItem == null)
          //       IconButton(
          //         onPressed: () {
          //           // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
          //           widget._cautionReceiverController
          //               .updateReceiverAnalyzingItemWithAccepted(
          //                   widget.cautionModel);
          //         },
          //         icon: const Icon(
          //           Icons.check_outlined,
          //         ),
          //       ),
          //     if (widget.cautionModel.receiverStartGiveback == false)
          //       IconButton(
          //         onPressed: () async {
          //           String? res = await showDialog(
          //             barrierDismissible: false,
          //             context: context,
          //             builder: (BuildContext context) {
          //               return const DialogDescription(
          //                 title: 'Descrição',
          //                 formFieldLabel: '',
          //               );
          //             },
          //           );
          //           if (res != null) {
          //             widget._cautionReceiverController
          //                 .updateReceiverStartGiveback(
          //                     widget.cautionModel, res);
          //           }
          //           // setState(() {});
          //         },
          //         icon: const Icon(
          //           Icons.assignment_return,
          //         ),
          //       ),
          //     if (widget.cautionModel.receiverIsPermanentItem == false &&
          //         widget.cautionModel.receiverAnalyzingItem == true)
          //       IconButton(
          //         onPressed: () {
          //           // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
          //           widget._cautionReceiverController
          //               .updateReceiverIsPermanentItem(
          //                   widget.cautionModel, true);
          //         },
          //         icon: const Icon(
          //           Icons.person,
          //         ),
          //       ),
          //     if (widget.cautionModel.receiverIsPermanentItem == true &&
          //         widget.cautionModel.receiverAnalyzingItem == true)
          //       IconButton(
          //         onPressed: () {
          //           // Get.toNamed(Routes.itemAddEdit, arguments: cautionModel);
          //           widget._cautionReceiverController
          //               .updateReceiverIsPermanentItem(
          //                   widget.cautionModel, false);
          //         },
          //         icon: const Icon(
          //           Icons.person_off,
          //         ),
          //       ),
          //   ],
          // ),
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
