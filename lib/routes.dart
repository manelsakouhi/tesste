import 'package:get/get.dart';
import 'package:teste/Admin/Admin.dart';
import 'package:teste/Visiteur_Simple/profil/update_profil.dart';
import 'package:teste/language/presentation/views/language.dart';

import 'Admin/Profile/update_profile.dart';
import 'Admin/widgets_create_events/create_event_view.dart';
import 'Admin/edit_event/edit_event_view._test.dart';
import 'Admin/widgets_create_events/edit_event_view.dart';
import 'Screens/login.dart';
import 'Visiteur_Simple/Visiteur.dart';
import 'Visiteur_pro/VisiteurPro.dart';
import 'Visiteur_pro/profil/update_profilpro.dart';
import 'core/constant/approutes.dart';
import 'core/middleware/mymiddelware.dart';
import 'settings/presentation/views/settings_view.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.language, page: () => const Language()),
  // GetPage(name: AppRoute.language, page: () => const Language()),
  GetPage(
      name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),

  GetPage(name: AppRoute.login, page: () => const LoginPage()),
  GetPage(name: AppRoute.admin, page: () =>  Admin()),
  GetPage(name: AppRoute.visiteur, page: () => const Visiteur()),
  GetPage(name: AppRoute.visiteurProf, page: () => const VisiteurPro()),

  GetPage(name: AppRoute.updateProfil, page: () => const UpdateProfil()),
   GetPage(name: AppRoute.updateProfilPro, page: () => const UpdateProfilpro()),
   GetPage(name: AppRoute.updateProfilAdmin, page: () => const UpdateProfileAdmin()),
   GetPage(name: AppRoute.settingsView, page: () => const SettingsView()),
   GetPage(name: AppRoute.createEventView, page: () => const CreateEventView()),
   GetPage(name: AppRoute.editEventView, page: () => EditEventView()),
];
