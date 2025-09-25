import 'package:dio/dio.dart';
import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import '../models/pet_model.dart';

class PetRemoteDataSource {
  final Dio dio;

  PetRemoteDataSource(this.dio);

  Future<List<PetModel>> getAvailablePets(String status) async {
    final response = await dio.get(
      '/pet/findByStatus',
      queryParameters: {'status': status},
    );

    final List data = response.data as List;
    return data.map((e) => PetModel.fromJson(e)).toList();
  }

  Future<void> createPet(PetCreateRequest request) async {
    await dio.post('/pet', data: request.toJson());
  }

  Future<void> deletePet(int id) async {
    await dio.delete(
      '/pet/$id',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> updatePet(PetUpdateRequest request) async {
    await dio.put("/pet", data: request.toJson());
  }
}
