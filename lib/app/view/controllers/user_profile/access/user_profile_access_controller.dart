import 'dart:developer';

import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/data/b4a/table/user_profile/user_profile_repository_exception.dart';
import 'package:cimabe/app/data/repositories/user_profile_repository.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserProfileAccessController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  UserProfileAccessController({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<UserProfileModel>();
  UserProfileModel? get userProfile => _userProfile.value;
  set userProfile(UserProfileModel? profileModelNew) =>
      _userProfile(profileModelNew);

  String? clientId;

//+++ forms
  final routesTec = TextEditingController();
  final restrictionsTec = TextEditingController();
  bool isActive = true;
//--- forms

  @override
  void onReady() {
    clientId = Get.arguments;
    getProfile();
    super.onReady();
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> getProfile() async {
    _loading(true);
    log('+++> getProfile $clientId', name: 'getProfile');
    UserProfileModel? userProfileModelTemp =
        await _userProfileRepository.readById(clientId!);
    userProfile = userProfileModelTemp;
    setFormFieldControllers();
    _loading(false);
  }

  setFormFieldControllers() {
    routesTec.text = userProfile?.routes?.join(',') ?? "";
    restrictionsTec.text = userProfile?.restrictions?.join(',') ?? "";
    isActive = userProfile?.isActive ?? false;
  }

  Future<void> updateAccess({
    bool? isActive,
    String? routes,
    String? restrictions,
  }) async {
    try {
      _loading(true);

      userProfile = userProfile!.copyWith(
        isActive: isActive,
        routes: routes != null ? routes.split(',') : [],
        restrictions: restrictions != null ? restrictions.split('\n') : [],
      );

      await _userProfileRepository.update(userProfile!);
    } on UserProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
