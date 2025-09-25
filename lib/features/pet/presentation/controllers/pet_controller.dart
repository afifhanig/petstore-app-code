import 'package:get/get.dart';
import '../../domain/entities/pet.dart';
import '../../domain/usecases/get_available_pets.dart';

class PetController extends GetxController {
  final GetAvailablePets getAvailablePets;

  PetController(this.getAvailablePets);

  var pets = <Pet>[].obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchPets('available');
  }

  Future<void> fetchPets(String status) async {
    try {
      isLoading.value = true;
      final result = await getAvailablePets(status);
      pets.assignAll(result);
    } catch (e) {
      errorMessage.value = "Error fetching pets: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
