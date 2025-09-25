import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:petstore_app/features/admin/presentation/bindings/admin_binding.dart';
import 'package:petstore_app/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:petstore_app/features/pet/presentation/bindings/order_binding.dart';
import 'package:petstore_app/features/pet/presentation/pages/order_page.dart';
import 'package:petstore_app/features/pet/presentation/pages/order_success_page.dart';
import '../features/pet/presentation/pages/pet_list_page.dart';
import '../features/pet/presentation/bindings/pet_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    //mobile-app
    GetPage(
      name: '${AppRoutes.petList}/:status',
      page: () => const PetListPage(),
      binding: PetBinding(),
    ),
    GetPage(
      name: AppRoutes.order,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        return OrderPage(petId: args?['petId']);
      },
      binding: OrderBinding(),
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        return OrderSuccessPage(
          orderId: args?['orderId'],
          orderQty: args?['orderQty'],
        );
      },
    ),

    //web-app
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () {
        if (kIsWeb) {
          return const AdminDashboardPage();
        } else {
          Future.microtask(() => Get.offAllNamed(AppRoutes.petList));
          return const SizedBox.shrink();
        }
      },
      binding: AdminBinding(),
    ),
  ];
}
