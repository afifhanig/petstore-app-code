import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/features/pet/domain/entities/order.dart';
import '../controllers/order_controller.dart';

class OrderPage extends StatelessWidget {
  final int? petId;
  const OrderPage({super.key, this.petId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    final petIdController = TextEditingController(
      text: petId?.toString() ?? "",
    );
    final qtyController = TextEditingController(text: "1");

    return Scaffold(
      appBar: AppBar(title: const Text("Simulate Purchase")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: petIdController,
              decoration: const InputDecoration(labelText: "Pet ID"),
              keyboardType: TextInputType.number,
              enabled: false,
            ),
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }
              if (controller.errorMessage.value != null) {
                return Text(
                  controller.errorMessage.value!,
                  style: const TextStyle(color: Colors.red),
                );
              }
              if (controller.orderResult.value != null) {
                return Text(
                  "Order Success!",
                  style: const TextStyle(color: Colors.green),
                );
              }
              return const SizedBox();
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final order = Order(
                  petId: int.tryParse(petIdController.text),
                  quantity: int.tryParse(qtyController.text),
                  status: "placed",
                  complete: true,
                );
                controller.createOrder(order);
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
