import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cimabe/app/core/utils/allowed_access.dart';
import 'package:cimabe/app/routes.dart';
import 'package:cimabe/app/view/controllers/splash/splash_controller.dart';
import 'package:cimabe/app/view/pages/home/parts/popmenu_user.dart';

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
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              CardHome(
                title: 'Gerenciar usuários',
                access: const ['admin'],
                onAction: () {
                  Get.toNamed(Routes.userProfileSearch);
                },
                icon: Icons.people,
                color: Colors.black87,
              ),
              CardHome(
                title: 'Adicionar item',
                access: const ['patrimonio'],
                onAction: () {
                  Get.toNamed(Routes.itemAddEdit);
                },
                icon: Icons.add,
                color: Colors.black54,
              ),
              CardHome(
                title: 'Buscar item',
                access: const ['patrimonio'],
                onAction: () {
                  Get.toNamed(Routes.itemSearch);
                },
                icon: Icons.content_paste_search,
                color: Colors.black54,
              ),
              CardHome(
                title: 'Entregar item',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionDeliverySearch, arguments: null);
                },
                icon: Icons.keyboard_tab,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Receber item',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionGiveback);
                },
                icon: Icons.keyboard_return,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Buscar item',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionSearch);
                },
                icon: Icons.search,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Meus itens temporários',
                access: const ['operador'],
                onAction: () {
                  Get.toNamed(Routes.cautionReceiver);
                },
                icon: Icons.access_time,
                color: Colors.black26,
              ),
              CardHome(
                title: 'Meus itens permanentes',
                access: const ['operador'],
                onAction: () {
                  Get.toNamed(Routes.cautionReceiverPermanent);
                },
                icon: Icons.timelapse,
                color: Colors.black26,
              ),
              CardHome(
                title: 'Histórico de cautelas',
                access: const ['operador'],
                onAction: () {
                  Get.toNamed(Routes.cautionReceiverHistory);
                },
                icon: Icons.av_timer,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHome extends StatelessWidget {
  final List<String> access;
  final Function() onAction;
  final String title;
  final IconData icon;
  final Color color;
  const CardHome({
    Key? key,
    required this.access,
    required this.onAction,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(access)) {
      return InkWell(
        onTap: onAction,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 150,
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color,
            ),
            child: Column(children: [
              Icon(
                icon,
                size: 50,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              )
            ]),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
//  class AccessOperators extends StatelessWidget {
//   const AccessOperators({super.key});

//   const AccessOperators({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (AllowedAccess.consultFor(['admin'])) {
//       return Card(
//         child: Row(
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Icon(
//                 Icons.people,
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Atualizar acesso de operadores'),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Get.toNamed(Routes.userProfileSearch);
//                       },
//                       icon: const Icon(Icons.search),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }

class Items extends StatelessWidget {
  const Items({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(['patrimonio'])) {
      return Card(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.add_moderator,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gerenciar itens'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.itemAddEdit);
                      },
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.itemSearch);
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

class DeliveryItem extends StatelessWidget {
  const DeliveryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(['reserva'])) {
      return Card(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.delivery_dining,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fluxo de itens'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionDeliverySearch);
                      },
                      icon: const Icon(Icons.keyboard_tab),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionGiveback);
                      },
                      icon: const Icon(Icons.keyboard_return),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionSearch);
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

class ReceiverItem extends StatelessWidget {
  const ReceiverItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(['operador'])) {
      return Card(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.receipt_long_outlined,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Meus itens'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionReceiver);
                      },
                      icon: const Icon(Icons.access_time),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionReceiverPermanent);
                      },
                      icon: const Icon(Icons.gps_fixed),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.cautionReceiverHistory);
                      },
                      icon: const Icon(Icons.history_edu),
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
