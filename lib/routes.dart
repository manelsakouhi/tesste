import 'package:get/get.dart';
import 'package:teste/Admin/Admin.dart';
import 'package:teste/Visiteur_Simple/profil/update_profil.dart';
import 'package:teste/language/presentation/views/language.dart';

import 'Screens/login.dart';
import 'Visiteur_Simple/Visiteur.dart';
import 'Visiteur_pro/VisiteurPro.dart';
import 'core/constant/approutes.dart';
import 'core/middleware/mymiddelware.dart';

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
];
