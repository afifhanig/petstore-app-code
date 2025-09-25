import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petstore_app/features/admin/domain/usecases/create_pet.dart';
import 'package:petstore_app/features/admin/domain/usecases/delete_pet.dart';
import 'package:petstore_app/features/admin/domain/usecases/update_pet.dart';
import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import 'package:petstore_app/features/pet/domain/entities/pet.dart';
import 'package:petstore_app/features/pet/domain/usecases/get_available_pets.dart';

class PetAdminController extends GetxController {
  final GetAvailablePets getAvailablePets;
  final CreatePet createPet;
  final UpdatePet updatePet;
  final DeletePet deletePet;

  PetAdminController(
    this.getAvailablePets,
    this.createPet,
    this.updatePet,
    this.deletePet,
  );

  final pets = <Pet>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final box = GetStorage();
  var localSearchPets = <Pet>[].obs;
  var searchQuery = "".obs;
  var selectedStatus = "available".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets("available");

    ever(selectedStatus, (value) {
      fetchPets(selectedStatus.value);
    });
  }

  List<Pet> _loadPetsFromStorage() {
    final data = box.read('pets');
    if (data == null) return [];

    return (data as List).map((e) {
      final map = Map<String, dynamic>.from(e);
      return Pet(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        status: map['status'] ?? '',
        categoryName: map['categoryName'] ?? '',
        photoUrl: map['photoUrl'] ?? '',
      );
    }).toList();
  }

  void _savePetsToStorage(List<Pet> pets) {
    box.write(
      'pets',
      pets.map((p) {
        return {
          'id': p.id,
          'name': p.name,
          'status': p.status ?? '',
          'categoryName': p.categoryName ?? '',
          'photoUrl': p.photoUrl,
        };
      }).toList(),
    );
  }

  Future<void> fetchPets(String status) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      if (selectedStatus.value == '') {
        box.remove('pets');
      }
      final localPets = _loadPetsFromStorage();
      final result = await getAvailablePets(status);
      final merged = [...localPets];
      for (final pet in result) {
        if (!merged.any((p) => p.id == pet.id)) {
          merged.add(pet);
        }
      }
      _savePetsToStorage(merged);
      pets.assignAll(
        merged.where((p) => p.status == selectedStatus.value).toList(),
      );
      localSearchPets.assignAll(
        merged.where((p) => p.status == selectedStatus.value).toList(),
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPet(
    String name,
    String status,
    int categoryId,
    String categoryName,
    String photoUrl,
  ) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      final request = PetCreateRequest(
        id: id,
        name: name,
        status: status,
        categoryId: categoryId,
        categoryName: categoryName,
        photoUrl: photoUrl,
      );

      final localRequest = Pet(
        id: id,
        name: name,
        status: status,
        categoryName: categoryName,
        photoUrl: photoUrl,
      );

      await createPet(request);
      _savePetsToStorage([localRequest]);
      if (!pets.any((p) => p.id == localRequest.id)) {
        pets.add(localRequest);
      }

      Get.back();
      Get.snackbar(
        "Success",
        "Pet '$name' has been added successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(100),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(100),
        colorText: Colors.white,
      );
    }
  }

  Future<void> editPet(PetUpdateRequest request) async {
    try {
      await updatePet(request);
      int index = pets.indexWhere((p) => p.id == request.id);
      if (index != -1) {
        pets[index] = Pet(
          id: request.id,
          name: request.name,
          status: request.status,
          categoryName: request.categoryName,
          photoUrl: request.photoUrl,
        );
        pets.refresh();
      }
      _savePetsToStorage(pets);

      Get.back();
      Get.snackbar(
        "Success",
        "Pet updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(100),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update pet: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(100),
        colorText: Colors.white,
      );
    }
  }

  Future<void> deletePets(int id) async {
    try {
      await deletePet(id);
      pets.removeWhere((p) => p.id == id);
      _savePetsToStorage(pets);
      Get.snackbar(
        "Success",
        "Pet with $id has been deleted",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withAlpha(100),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(100),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    var filtered = localSearchPets.toList();

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where(
            (pet) => pet.name!.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }

    pets.assignAll(filtered);
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void updateStatus(String status) {
    selectedStatus.value = status;
    applyFilters();
  }
}
