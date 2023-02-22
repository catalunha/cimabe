import 'package:cimabe/app/view/controllers/caution/delivery/caution_delivery_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class CautionDeliverySearchPage extends StatefulWidget {
  CautionDeliverySearchPage({Key? key}) : super(key: key);
  final _cautionDeliveryController = Get.find<CautionDeliveryController>();

  @override
  State<CautionDeliverySearchPage> createState() =>
      _CautionDeliverySearchPageState();
}

class _CautionDeliverySearchPageState extends State<CautionDeliverySearchPage> {
  final _formKey = GlobalKey<FormState>();
  final serieTEC = TextEditingController();
  final loteTEC = TextEditingController();
  final registerTEC = TextEditingController();
  final quantityTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    serieTEC.text = "";
    loteTEC.text = "";
    registerTEC.text = widget._cautionDeliveryController.registerEnd;
    quantityTEC.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cautela de item - Busca'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveItem();
          if (result) {
            // Get.back();
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
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Card(
                      child: Column(children: [
                        AppTextFormField(
                          label: 'Informe a Série do item',
                          controller: serieTEC,
                        ),
                        const Text('OU'),
                        AppTextFormField(
                          label: 'Informe o Lote do item',
                          controller: loteTEC,
                        ),
                      ]),
                    ),
                    const Divider(
                      height: 5,
                    ),
                    AppTextFormField(
                      label: 'Informe o Registro do PM',
                      controller: registerTEC,
                      validator: Validatorless.required(
                          'Registro do PM é obrigatório'),
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      height: 10,
                    ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: 'Quantidade deste item a ser cautelado:',
                      controller: quantityTEC,
                      validator: Validatorless.multiple([
                        Validatorless.number('Apenas números.'),
                        Validatorless.required('Quantidade é obrigatório'),
                        Validatorless.min(1, 'Valor mínimo é 1 (uma) unidade'),
                        Validatorless.max(
                            100, 'Valor máximo é 100 (cem) unidades'),
                      ]),
                    ),
                    const SizedBox(height: 70),
                  ],
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
      await widget._cautionDeliveryController.add(
          serie: serieTEC.text,
          lote: loteTEC.text,
          register: registerTEC.text,
          quantity: int.tryParse(quantityTEC.text) == null
              ? 1
              : int.parse(quantityTEC.text));
      return true;
    }
    return false;
  }
}
