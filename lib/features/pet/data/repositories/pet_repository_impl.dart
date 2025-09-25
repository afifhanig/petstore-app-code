import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';

import '../../domain/entities/pet.dart';
import '../../domain/repositories/pet_repository.dart';
import '../datasources/pet_remote_datasource.dart';
import '../models/pet_model.dart';

class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource remoteDataSource;

  PetRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Pet>> getAvailablePets(String status) async {
    final List<PetModel> models = await remoteDataSource.getAvailablePets(
      status,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> createPet(PetCreateRequest request) {
    return remoteDataSource.createPet(request);
  }

  @override
  Future<void> updatePet(PetUpdateRequest request) {
    return remoteDataSource.updatePet(request);
  }

  @override
  Future<void> deletePet(int id) {
    return remoteDataSource.deletePet(id);
  }
}
