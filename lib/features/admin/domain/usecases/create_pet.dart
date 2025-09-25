import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

class CreatePet {
  final PetRepository repository;

  CreatePet(this.repository);

  Future<void> call(PetCreateRequest request) {
    return repository.createPet(request);
  }
}
