import 'package:cimabe/app/view/controllers/home/home_dependencies.dart';
import 'package:cimabe/app/view/controllers/item/addedit/item_addedit_dependencies.dart';
import 'package:cimabe/app/view/controllers/item/search/item_search_dependencies.dart';
import 'package:cimabe/app/view/controllers/splash/splash_dependencies.dart';
import 'package:cimabe/app/view/controllers/user/login/login_dependencies.dart';
import 'package:cimabe/app/view/controllers/user/register/email/user_register_email_dependencies.dart';
import 'package:cimabe/app/view/controllers/user_profile/access/user_profile_access_dependencies.dart';
import 'package:cimabe/app/view/controllers/user_profile/edit/user_profile_edit_dependencies.dart';
import 'package:cimabe/app/view/controllers/user_profile/search/user_profile_search_dependencies.dart';
import 'package:cimabe/app/view/controllers/user_profile/view/user_profile_view_dependencies.dart';
import 'package:cimabe/app/view/pages/home/home_page.dart';
import 'package:cimabe/app/view/pages/item/addedit/item_addedit_page.dart';
import 'package:cimabe/app/view/pages/item/search/item_search_list_page.dart';
import 'package:cimabe/app/view/pages/item/search/item_search_page.dart';
import 'package:cimabe/app/view/pages/splash/splash_page.dart';
import 'package:cimabe/app/view/pages/user/login/auth_login_page.dart';
import 'package:cimabe/app/view/pages/user/register/email/user_register_email.page.dart';
import 'package:cimabe/app/view/pages/user_profile/access/user_profile_access_page.dart';
import 'package:cimabe/app/view/pages/user_profile/edit/user_profile_edit_page.dart';
import 'package:cimabe/app/view/pages/user_profile/search/user_profile_search_list_page.dart';
import 'package:cimabe/app/view/pages/user_profile/search/user_profile_search_page.dart';
import 'package:cimabe/app/view/pages/user_profile/view/user_profile_view_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const userLogin = '/user/login';
  static const userRegisterEmail = '/user/register/email';
  static const home = '/home';

  static const userProfileEdit = '/user/profile/edit';
  static const userProfileSearch = '/user/profile/search';
  static const userProfileSearchList = '/user/profile/search/list';
  static const userProfileAccess = '/user/profile/access';
  static const userProfileView = '/user/profile/view';

  static const itemAddEdit = '/item/addedit';
  static const itemSearch = '/item/search';
  static const itemSearchList = '/item/search/list';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.userLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.userRegisterEmail,
      binding: UserRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => HomePage(),
      children: const [],
    ),
    GetPage(
      name: Routes.userProfileEdit,
      binding: UserProfileEditDependencies(),
      page: () => UserProfileEditPage(),
    ),
    GetPage(
      name: Routes.userProfileSearch,
      binding: UserProfileSearchDependencies(),
      page: () => UserProfileSearchPage(),
    ),
    GetPage(
      name: Routes.userProfileSearchList,
      page: () => UserProfileSearchListPage(),
    ),
    GetPage(
      name: Routes.userProfileAccess,
      binding: UserProfileAccessDependencies(),
      page: () => UserProfileAccessPage(),
    ),
    GetPage(
      name: Routes.userProfileView,
      binding: UserProfileViewDependencies(),
      page: () => UserProfileViewPage(),
    ),
    GetPage(
      name: Routes.itemAddEdit,
      binding: ItemAddEditDependencies(),
      page: () => ItemAddEditPage(),
    ),
    GetPage(
      name: Routes.itemSearch,
      binding: ItemSearchDependencies(),
      page: () => ItemSearchPage(),
    ),
    GetPage(
      name: Routes.itemSearchList,
      page: () => ItemSearchListPage(),
    ),
  ];
}
