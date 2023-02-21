import 'package:cimabe/app/view/controllers/caution/search/caution_search_controller.dart';
import 'package:cimabe/app/view/pages/caution/search/part/caution_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionSearchListPage extends StatelessWidget {
  final _itemSearchController = Get.find<CautionSearchController>();

  CautionSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Cautelas encontradas: ${_itemSearchController.cautionList.length}'),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              _itemSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _itemSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _itemSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: CautionList(
                cautionList: _itemSearchController.cautionList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
