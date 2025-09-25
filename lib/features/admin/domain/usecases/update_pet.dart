import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

class UpdatePet {
  final PetRepository repository;

  UpdatePet(this.repository);

  Future<void> call(PetUpdateRequest id) {
    return repository.updatePet(id);
  }
}
