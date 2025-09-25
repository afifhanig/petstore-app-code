import 'package:get/get.dart';
import 'package:petstore_app/core/network/dio_client.dart';
import 'package:petstore_app/features/admin/domain/usecases/create_pet.dart';
import 'package:petstore_app/features/admin/domain/usecases/delete_pet.dart';
import 'package:petstore_app/features/admin/domain/usecases/update_pet.dart';
import 'package:petstore_app/features/admin/presentation/controllers/pet_admin_controller.dart';
import 'package:petstore_app/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:petstore_app/features/pet/data/repositories/pet_repository_impl.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';
import 'package:petstore_app/features/pet/domain/usecases/get_available_pets.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    // Data
    Get.lazyPut<PetRemoteDataSource>(
      () => PetRemoteDataSource(Get.find<DioClient>().dio),
    );
    Get.lazyPut<PetRepository>(() => PetRepositoryImpl(Get.find()));

    // Domain
    Get.lazyPut(() => GetAvailablePets(Get.find()));
    Get.lazyPut(() => CreatePet(Get.find()));
    Get.lazyPut(() => DeletePet(Get.find()));
    Get.lazyPut(() => UpdatePet(Get.find()));

    // Presentation
    Get.lazyPut(
      () => PetAdminController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
  }
}
