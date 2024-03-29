import 'dart:developer';
import 'package:cimabe/app/view/controllers/user/register/email/user_register_email_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_button.dart';
import 'package:cimabe/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class AuthRegisterEmailPage extends StatefulWidget {
  final _authRegisterEmailController = Get.find<UserRegisterEmailController>();

  AuthRegisterEmailPage({Key? key}) : super(key: key);

  @override
  State<AuthRegisterEmailPage> createState() => _AuthRegisterEmailPageState();
}

class _AuthRegisterEmailPageState extends State<AuthRegisterEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _phoneEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constrainsts) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constrainsts.maxHeight,
                  maxWidth: 400,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cadastro',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: context.theme.primaryColorDark,
                            ),
                          ),
                          const Text(
                              'Preencha os campos abaixo para criar o seu cadastro.'),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            label: 'E-mail',
                            controller: _emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('email obrigatório.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            label: 'Senha',
                            obscureText: true,
                            controller: _passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória.'),
                              Validatorless.min(6, 'Minimo de 6 caracteres.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            label: 'Confirme senha',
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'confirmação de senha obrigatória.'),
                                Validatorless.min(6, 'Minimo de 6 caracteres.'),
                                Validatorless.compare(_passwordEC,
                                    'Senha diferente do informado anteriormente.')
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                              'Após clicar em CADASTRAR você receberá um email para validação deste cadastro. É necessário ir na caixa de entrada do email informado aqui e validar seu cadastro antes de tentar login.'),
                          const SizedBox(
                            height: 20,
                          ),
                          AppButton(
                            label: 'Cadastrar',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                log('formValid');
                                widget._authRegisterEmailController
                                    .registerEmail(
                                  email: _emailEC.text.trim(),
                                  password: _passwordEC.text.trim(),
                                );
                              } else {
                                log('formNotValid');
                              }
                            },
                            width: context.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
