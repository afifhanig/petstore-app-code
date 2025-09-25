import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

class DeletePet {
  final PetRepository repository;

  DeletePet(this.repository);

  Future<void> call(int id) {
    return repository.deletePet(id);
  }
}
