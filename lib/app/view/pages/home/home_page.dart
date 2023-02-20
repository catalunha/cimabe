import 'package:cimabe/app/core/utils/allowed_access.dart';
import 'package:cimabe/app/routes.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
import 'package:cimabe/app/view/pages/home/parts/popmenu_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${_splashController.userModel!.userProfile!.nickname ?? 'Atualize seu perfil.'}.")),
        actions: [
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeOperators(),
          ],
        ),
      ),
    );
  }
}

class HomeOperators extends StatelessWidget {
  const HomeOperators({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(['admin'])) {
      return Card(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.people,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Atualizar acesso de operadores'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.userProfileSearch);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
