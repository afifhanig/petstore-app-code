import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/routes/app_routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "404 - Page Not Found",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.adminDashboard),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
