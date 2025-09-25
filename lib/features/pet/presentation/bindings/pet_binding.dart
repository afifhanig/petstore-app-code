import 'package:get/get.dart';
import 'package:petstore_app/core/network/dio_client.dart';
import 'package:petstore_app/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:petstore_app/features/pet/data/repositories/pet_repository_impl.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';
import 'package:petstore_app/features/pet/domain/usecases/get_available_pets.dart';
import 'package:petstore_app/features/pet/presentation/controllers/pet_controller.dart';

class PetBinding extends Bindings {
  @override
  void dependencies() {
    // Data
    Get.lazyPut<PetRemoteDataSource>(
      () => PetRemoteDataSource(Get.find<DioClient>().dio),
    );
    Get.lazyPut<PetRepository>(() => PetRepositoryImpl(Get.find()));

    // Domain
    Get.lazyPut(() => GetAvailablePets(Get.find()));

    // Presentation
    Get.lazyPut(() => PetController(Get.find()));
  }
}
