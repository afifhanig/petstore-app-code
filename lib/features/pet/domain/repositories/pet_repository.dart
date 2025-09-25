import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import '../entities/pet.dart';

abstract class PetRepository {
  Future<List<Pet>> getAvailablePets(String status);
  Future<void> createPet(PetCreateRequest request);
  Future<void> updatePet(PetUpdateRequest request);
  Future<void> deletePet(int id);
}
