import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petstore_app/core/utils/core_binding.dart';
import 'package:petstore_app/features/admin/presentation/pages/not_found_page.dart';
import 'package:petstore_app/routes/app_pages.dart';
import 'package:petstore_app/routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Petstore',
      debugShowCheckedModeBanner: false,
      initialBinding: CoreBinding(),
      initialRoute: kIsWeb ? AppRoutes.adminDashboard : AppRoutes.petList,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const NotFoundPage(),
      ),
    );
  }
}
