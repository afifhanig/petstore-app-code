import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/routes/app_routes.dart';
import '../../presentation/controllers/pet_controller.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PetController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Available Pets")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pets.isEmpty) {
          return const Center(child: Text("No pets found"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchPets('available'),
          child: ListView.builder(
            itemCount: controller.pets.length,
            itemBuilder: (context, index) {
              final pet = controller.pets[index];
              return Card(
                child: ListTile(
                  leading: pet.photoUrl != null
                      ? Image.network(
                          pet.photoUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.pets, size: 40);
                          },
                        )
                      : const Icon(Icons.pets, size: 40),
                  title: Text(pet.name ?? 'Unnamed Pet'),
                  subtitle: Text(
                    "Status: ${pet.status ?? 'unknown'}"
                    "\nCategory: ${pet.categoryName ?? 'none'}",
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.order,
                        arguments: {"petId": pet.id},
                      );
                    },
                    child: const Text("Order"),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
