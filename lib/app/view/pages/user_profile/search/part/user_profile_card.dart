import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/view/controllers/user_profile/search/user_profile_search_controller.dart';
import 'package:cimabe/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileCard extends StatelessWidget {
  final _clientSearchController = Get.find<UserProfileSearchController>();

  final UserProfileModel profile;
  UserProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              profile.photo != null && profile.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        profile.photo!,
                        height: 58,
                        width: 58,
                      ),
                    )
                  : const SizedBox(
                      height: 58,
                      width: 58,
                      child: Icon(Icons.person_outline),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppTextTitleValue(
                    //   title: 'Id: ',
                    //   value: profile.id,
                    // ),
                    AppTextTitleValue(
                      title: 'Email: ',
                      value: profile.email,
                    ),
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${profile.name}',
                    ),
                    AppTextTitleValue(
                      title: 'Nickname: ',
                      value: '${profile.name}',
                    ),
                    AppTextTitleValue(
                      title: 'Telefone: ',
                      value: '${profile.phone}',
                    ),
                    AppTextTitleValue(
                      title: 'Registro: ',
                      value: '${profile.register}',
                    ),
                    // Wrap(
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         Get.toNamed(Routes.clientProfileEdit,
                    //             arguments: profile.id);
                    //       },
                    //       icon: const Icon(
                    //         Icons.edit,
                    //       ),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {
                    //         Get.toNamed(Routes.clientProfileView, arguments: {
                    //           'clientId': profile.id,
                    //           'includeColumns':
                    //               _clientSearchController.includeColumns
                    //         });
                    //       },
                    //       icon: const Icon(
                    //         Icons.assignment_ind_outlined,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
