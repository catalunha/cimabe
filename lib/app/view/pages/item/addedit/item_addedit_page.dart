import 'package:cimabe/app/view/controllers/item/addedit/item_addedit_controller.dart';
import 'package:cimabe/app/view/pages/user_profile/edit/part/user_profile_photo.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemAddEditPage extends StatefulWidget {
  ItemAddEditPage({Key? key}) : super(key: key);
  final _itemAddEditController = Get.find<ItemAddEditController>();

  @override
  State<ItemAddEditPage> createState() => _ItemAddEditPageState();
}

class _ItemAddEditPageState extends State<ItemAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionTEC = TextEditingController();
  final serieTEC = TextEditingController();
  final loteTEC = TextEditingController();
  final brandTEC = TextEditingController();
  final modelTEC = TextEditingController();
  final calibreTEC = TextEditingController();
  final docTEC = TextEditingController();
  final obsCautionTEC = TextEditingController();
  bool isMunition = false;
  bool isBlockedOperator = false;
  bool isBlockedDoc = false;
  final groupsTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    descriptionTEC.text = widget._itemAddEditController.item?.description ?? "";
    serieTEC.text = widget._itemAddEditController.item?.serie ?? "";
    loteTEC.text = widget._itemAddEditController.item?.lote ?? "";
    brandTEC.text = widget._itemAddEditController.item?.brand ?? "";
    modelTEC.text = widget._itemAddEditController.item?.model ?? "";
    calibreTEC.text = widget._itemAddEditController.item?.calibre ?? "";
    docTEC.text = widget._itemAddEditController.item?.doc ?? "";
    obsCautionTEC.text = widget._itemAddEditController.item?.obsCaution ?? "";
    isMunition = widget._itemAddEditController.item?.isMunition ?? false;
    isBlockedOperator =
        widget._itemAddEditController.item?.isBlockedOperator ?? false;
    isBlockedDoc = widget._itemAddEditController.item?.isBlockedDoc ?? false;
    groupsTEC.text =
        widget._itemAddEditController.item?.groups?.join('\n') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar/Editar este item'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveItem();
          if (result) {
            Get.back();
          } else {
            Get.snackbar(
              'Atenção',
              'Campos obrigatórios não foram preenchidos.',
              backgroundColor: Colors.red,
            );
          }
        },
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(height: 5),
                      AppTextFormField(
                        label: 'Descrição',
                        controller: descriptionTEC,
                      ),
                      AppTextFormField(
                        label: 'Série',
                        controller: serieTEC,
                      ),
                      AppTextFormField(
                        label: 'Lote',
                        controller: loteTEC,
                      ),
                      AppTextFormField(
                        label: 'Marca',
                        controller: brandTEC,
                      ),
                      AppTextFormField(
                        label: 'Modelo',
                        controller: modelTEC,
                      ),
                      AppTextFormField(
                        label: 'Calibre',
                        controller: calibreTEC,
                      ),
                      AppTextFormField(
                        label: 'Documentação',
                        controller: docTEC,
                        maxLines: 5,
                      ),
                      AppTextFormField(
                        label: 'Observações para cautelar',
                        controller: obsCautionTEC,
                      ),
                      CheckboxListTile(
                        title: const Text("É uma munição de arma de fogo ?"),
                        value: isMunition,
                        onChanged: (value) {
                          setState(() {
                            isMunition = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Esta bloqueada para cautela ?"),
                        value: isBlockedOperator,
                        onChanged: (value) {
                          setState(() {
                            isBlockedOperator = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Esta bloqueada pela documentação ?"),
                        value: isBlockedDoc,
                        onChanged: (value) {
                          setState(() {
                            isBlockedDoc = value!;
                          });
                        },
                      ),
                      AppTextFormField(
                        label: 'Grupos a que pertence:',
                        controller: groupsTEC,
                        maxLines: 5,
                      ),
                      UserProfileEditPhoto(
                        label: 'Click aqui para buscar uma foto.',
                        photoUrl: widget._itemAddEditController.item?.photo,
                        setXFile: (value) =>
                            widget._itemAddEditController.xfile = value,
                      ),
                      const SizedBox(height: 5),
                      const Text('Validade'),
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: CupertinoDatePicker(
                          initialDateTime:
                              widget._itemAddEditController.validate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDate) {
                            widget._itemAddEditController.validate = newDate;
                          },
                        ),
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> saveItem() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._itemAddEditController.addedit(
        description: descriptionTEC.text,
        serie: serieTEC.text,
        lote: loteTEC.text,
        brand: brandTEC.text,
        model: modelTEC.text,
        calibre: calibreTEC.text,
        doc: docTEC.text,
        obsCaution: obsCautionTEC.text,
        isMunition: isMunition,
        isBlockedOperator: isBlockedOperator,
        isBlockedDoc: isBlockedDoc,
        groups: groupsTEC.text,
      );
      return true;
    }
    return false;
  }
}
