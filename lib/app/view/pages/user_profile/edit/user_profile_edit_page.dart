import 'package:cimabe/app/view/controllers/user_profile/edit/user_profile_edit_controller.dart';
import 'package:cimabe/app/view/pages/user_profile/edit/part/user_profile_photo.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class UserProfileEditPage extends StatefulWidget {
  UserProfileEditPage({Key? key}) : super(key: key);
  final _userProfileController = Get.find<UserProfileEditController>();

  @override
  // _UserProfileEditPageState createState() => _UserProfileEditPageState();
  State<UserProfileEditPage> createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final dateFormat = DateFormat('dd/MM/y');

  final _formKey = GlobalKey<FormState>();
  final _nicknameTec = TextEditingController();
  final _nameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _cpfTec = TextEditingController();
  final _registerTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nicknameTec.text =
        widget._userProfileController.userProfile?.nickname ?? "";
    _nameTec.text = widget._userProfileController.userProfile?.name ?? "";
    _phoneTec.text = widget._userProfileController.userProfile?.phone ?? "";
    _cpfTec.text = widget._userProfileController.userProfile?.cpf ?? "";
    _registerTec.text =
        widget._userProfileController.userProfile?.register ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
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
                child: Column(
                  children: [
                    // Text(
                    //   'Id: ${widget._userProfileController.userProfile!.id}',
                    // ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: '* Seu nome de tropa.',
                      controller: _nicknameTec,
                      validator:
                          Validatorless.required('Nome de tropa é obrigatório'),
                    ),
                    AppTextFormField(
                      label: '* Seu nome completo.',
                      controller: _nameTec,
                      validator: Validatorless.required('Nome é obrigatório'),
                    ),
                    AppTextFormField(
                        label: 'Seu telefone. Formato: DDDNÚMERO',
                        controller: _phoneTec,
                        validator: Validatorless.multiple([
                          Validatorless.number(
                              'Apenas números. Formato: DDDNÚMERO'),
                          Validatorless.required('Nome é obrigatório'),
                        ])),
                    AppTextFormField(
                        label: 'Seu CPF. Apenas números.',
                        controller: _cpfTec,
                        validator: Validatorless.multiple([
                          Validatorless.cpf('Este número não é CPF válido'),
                          Validatorless.number('Apenas números. Não use . - /'),
                          Validatorless.required('Nome é obrigatório'),
                        ])),
                    AppTextFormField(
                      label: 'O número de registro na corporação.',
                      controller: _registerTec,
                      validator: Validatorless.multiple([
                        Validatorless.number('Apenas números.'),
                        Validatorless.required('Nome é obrigatório'),
                      ]),
                    ),
                    const SizedBox(height: 5),
                    UserProfileEditPhoto(
                      photoUrl:
                          widget._userProfileController.userProfile!.photo,
                      setXFile: (value) =>
                          widget._userProfileController.xfile = value,
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

  Future<bool> saveProfile() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._userProfileController.append(
        nickname: _nicknameTec.text,
        name: _nameTec.text,
        phone: _phoneTec.text,
        cpf: _cpfTec.text,
        register: _registerTec.text,
      );
      return true;
    }
    return false;
  }
}
