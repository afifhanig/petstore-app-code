import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/features/admin/presentation/controllers/pet_admin_controller.dart';

class AddPetDialog extends StatelessWidget {
  AddPetDialog({super.key});

  final categories = {1: "Dogs", 2: "Cats", 3: "Birds"};
  final nameController = TextEditingController();
  final photoController = TextEditingController();
  final status = "available".obs;
  final categoryId = 1.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PetAdminController>();

    return AlertDialog(
      title: const Text("Add Pet"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Pet Name"),
          ),
          TextField(
            controller: photoController,
            decoration: const InputDecoration(labelText: "Photo URL"),
          ),
          const SizedBox(height: 12),
          Obx(
            () => DropdownButton<String>(
              value: status.value,
              items: const [
                DropdownMenuItem(value: "available", child: Text("Available")),
                DropdownMenuItem(value: "pending", child: Text("Pending")),
                DropdownMenuItem(value: "sold", child: Text("Sold")),
              ],
              onChanged: (val) => status.value = val!,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => DropdownButton<int>(
              value: categoryId.value,
              items: categories.entries
                  .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (val) => categoryId.value = val!,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (nameController.text.isNotEmpty &&
                photoController.text.isNotEmpty) {
              await controller.addPet(
                nameController.text,
                status.value,
                categoryId.value,
                categories[categoryId.value]!,
                photoController.text,
              );
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
