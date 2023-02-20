import 'package:cimabe/app/core/models/user_profile_model.dart';
import 'package:cimabe/app/data/repositories/user_profile_repository.dart';
import 'package:cimabe/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimabe/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class UserProfileViewController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  UserProfileViewController({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;
  // @override
  // void onReady() async {
  //   await getProfile();

  //   super.onReady();
  // }

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<UserProfileModel>();
  UserProfileModel? get userProfile => _userProfile.value;
  set userProfile(UserProfileModel? profileModelNew) =>
      _userProfile(profileModelNew);

  String? clientId;

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    clientId = Get.arguments;
    super.onInit();
  }

  Future<UserProfileModel> getUserProfile() async {
    UserProfileModel? profileModelTemp =
        await _userProfileRepository.readById(clientId!);
    userProfile = profileModelTemp;
    return profileModelTemp!;
  }
}
