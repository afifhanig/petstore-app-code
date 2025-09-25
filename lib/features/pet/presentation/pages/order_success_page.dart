import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class OrderSuccessPage extends StatelessWidget {
  final int? orderId;
  final int? orderQty;

  const OrderSuccessPage({super.key, this.orderId, this.orderQty});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.offAllNamed(AppRoutes.petList);
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 100, color: Colors.green),
                const SizedBox(height: 16),
                Text(
                  "Your order was placed successfully!",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                if (orderId != null) ...[
                  const SizedBox(height: 8),
                  Text("Pet ID: $orderId"),
                ],
                if (orderQty != null) ...[
                  const SizedBox(height: 8),
                  Text("Quantity: $orderQty"),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.petList);
                  },
                  child: const Text("Back to Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
