import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_app/features/admin/presentation/widgets/add_pet_dialog.dart';
import 'package:petstore_app/features/admin/presentation/widgets/edit_pet_dialog.dart';
import '../controllers/pet_admin_controller.dart';

class PetsPage extends GetView<PetAdminController> {
  const PetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pets List",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    Get.dialog(AddPetDialog());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Pet"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search by name...",
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 16,
                        ), // smaller icon
                        isDense: true, // make input more compact
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 8,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ), // smaller font for 30px height
                      onChanged: (val) => controller.updateSearch(val),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedStatus.value.isEmpty
                        ? null
                        : controller.selectedStatus.value,
                    hint: const Text(
                      "Filter by status",
                      style: TextStyle(fontSize: 14),
                    ),
                    items: ["available", "pending", "sold"]
                        .map(
                          (s) => DropdownMenuItem<String>(
                            value: s,
                            child: Text(s),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      controller.updateStatus(val ?? "");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: controller.pets.isEmpty
                  ? const Center(child: Text("No pets available"))
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                headingRowColor:
                                    WidgetStateProperty.resolveWith<Color?>((
                                      Set<WidgetState> states,
                                    ) {
                                      return Colors
                                          .grey
                                          .shade200; // Set the header row color to red
                                    }),
                                columns: const [
                                  DataColumn(label: Text("ID")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Category")),
                                  DataColumn(label: Text("Status")),
                                  DataColumn(label: Text("Photo URL")),
                                  DataColumn(label: Text("Actions")),
                                ],
                                rows: controller.pets.map((pet) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth / 7,
                                          ),
                                          child: Text(
                                            pet.id.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth / 7,
                                          ),
                                          child: Text(
                                            pet.name ?? '-',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth / 7,
                                          ),
                                          child: Text(
                                            pet.categoryName ?? "-",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(pet.status ?? "-")),
                                      DataCell(
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth / 7,
                                          ),
                                          child: Text(
                                            pet.photoUrl ?? "-",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Get.dialog(
                                                  EditPetDialog(pet: pet),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                controller.deletePets(pet.id);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    });
  }
}
