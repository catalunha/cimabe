import 'package:cimabe/app/view/controllers/user_profile/access/user_profile_access_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_container_photo.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class UserProfileAccessPage extends StatefulWidget {
  UserProfileAccessPage({Key? key}) : super(key: key);
  final _userProfileAccessController = Get.find<UserProfileAccessController>();

  @override
  // _UserProfileAccessPageState createState() => _UserProfileAccessPageState();
  State<UserProfileAccessPage> createState() => _UserProfileAccessPageState();
}

class _UserProfileAccessPageState extends State<UserProfileAccessPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar este operador'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveProfile();
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
                      // Text(
                      //   'Id: ${widget._userProfileAccessController.userProfile!.id}',
                      // ),
                      const SizedBox(height: 5),

                      AppContainerPhoto(
                        photoUrl: widget
                            ._userProfileAccessController.userProfile?.photo,
                      ),
                      AppTextTitleValue(
                        title: 'Email: ',
                        value: widget
                            ._userProfileAccessController.userProfile?.email,
                        inColumn: true,
                      ),
                      AppTextTitleValue(
                        inColumn: true,
                        title: 'Nome completo: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.name}',
                      ),
                      AppTextTitleValue(
                        inColumn: true,
                        title: 'Nome em tropa: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.nickname}',
                      ),
                      AppTextTitleValue(
                        title: 'Telefone: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.phone}',
                      ),
                      AppTextTitleValue(
                        title: 'CPF: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.cpf}',
                      ),
                      AppTextTitleValue(
                        title: 'Registro: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.register}',
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      CheckboxListTile(
                        title: const Text("* Liberar acesso ?"),
                        value: widget._userProfileAccessController.isActive,
                        onChanged: (value) {
                          setState(() {
                            widget._userProfileAccessController.isActive =
                                value!;
                          });
                        },
                      ),
                      const Text(
                          'As opções de rotas são: admin,reserva,operador,relatorio'),
                      const Text(
                          'Separador virgula. Sem espaços. Sem acentos.'),
                      AppTextFormField(
                        label: '* Rotas acessíveis:',
                        controller:
                            widget._userProfileAccessController.routesTec,
                        validator:
                            Validatorless.required('Rotas é obrigatório'),
                      ),
                      const Text('Veja opções de grupos.'),
                      AppTextFormField(
                        label: '* Restrições aos grupos:',
                        controller:
                            widget._userProfileAccessController.restrictionsTec,
                        maxLines: 3,
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

  Future<bool> saveProfile() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._userProfileAccessController.updateAccess(
        isActive: widget._userProfileAccessController.isActive,
        routes: widget._userProfileAccessController.routesTec.text,
        restrictions: widget._userProfileAccessController.restrictionsTec.text,
      );
      return true;
    }
    return false;
  }
}
