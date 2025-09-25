import '../entities/pet.dart';
import '../repositories/pet_repository.dart';

class GetAvailablePets {
  final PetRepository repository;

  GetAvailablePets(this.repository);

  Future<List<Pet>> call(String status) async {
    return await repository.getAvailablePets(status);
  }
}
