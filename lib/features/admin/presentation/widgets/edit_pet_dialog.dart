import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/features/admin/presentation/controllers/pet_admin_controller.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import 'package:petstore_app/features/pet/domain/entities/pet.dart';

class EditPetDialog extends StatefulWidget {
  final Pet pet;

  const EditPetDialog({super.key, required this.pet});

  @override
  State<EditPetDialog> createState() => _EditPetDialogState();
}

class _EditPetDialogState extends State<EditPetDialog> {
  late TextEditingController nameController;
  late TextEditingController photoController;
  late RxString status;
  late RxInt categoryId;
  late RxString categoryName;

  final List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "Dogs"},
    {"id": 2, "name": "Cats"},
    {"id": 3, "name": "Birds"},
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.pet.name);
    photoController = TextEditingController(text: widget.pet.photoUrl ?? "");
    status = (widget.pet.status ?? "available").obs;
    categoryName = (widget.pet.categoryName ?? "Dogs").obs;
    categoryId =
        (categories.firstWhere(
                  (c) => c["name"] == widget.pet.categoryName,
                  orElse: () => {"id": 1},
                )["id"]
                as int)
            .obs;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PetAdminController>();

    return AlertDialog(
      title: const Text("Edit Pet"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: photoController,
            decoration: const InputDecoration(labelText: "Photo URL"),
          ),
          Obx(
            () => DropdownButton<String>(
              value: status.value,
              items: [
                "available",
                "pending",
                "sold",
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => status.value = val!,
            ),
          ),
          Obx(
            () => DropdownButton<int>(
              value: categoryId.value,
              items: categories
                  .map(
                    (c) => DropdownMenuItem<int>(
                      value: c["id"] as int,
                      child: Text(c["name"] as String),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  categoryId.value = val;
                  categoryName.value =
                      categories.firstWhere((c) => c["id"] == val)["name"]
                          as String;
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            final req = PetUpdateRequest(
              id: widget.pet.id,
              name: nameController.text,
              status: status.value,
              categoryId: categoryId.value,
              categoryName: categoryName.value,
              photoUrl: photoController.text,
            );

            await controller.editPet(req);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
