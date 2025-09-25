import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:petstore_app/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_model.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import 'package:petstore_app/features/pet/data/repositories/pet_repository_impl.dart';

// Generate a mock for PetRemoteDataSource
@GenerateMocks([PetRemoteDataSource])
import 'pet_repository_impl_test.mocks.dart';

void main() {
  late PetRepositoryImpl repository;
  late MockPetRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPetRemoteDataSource();
    repository = PetRepositoryImpl(mockRemoteDataSource);
  });

  group('PetRepositoryImpl', () {
    final tPetModel = PetModel(
      id: 1,
      name: 'Doggo',
      status: 'available',
      category: CategoryModel(id: 1, name: 'Dogs'),
      photoUrls: ['string'],
    );

    final tPet = tPetModel.toEntity();

    final tCreateRequest = PetCreateRequest(
      id: 1,
      name: 'Doggo',
      status: 'available',
      categoryId: 1,
      categoryName: 'Dogs',
      photoUrl: 'string',
    );

    final tUpdateRequest = PetUpdateRequest(
      id: 1,
      name: 'Doggo Updated',
      status: 'available',
      categoryId: 1,
      categoryName: 'Dogs',
      photoUrl: 'string',
    );

    test('getAvailablePets should return list of Pet entities', () async {
      // arrange
      when(
        mockRemoteDataSource.getAvailablePets(any),
      ).thenAnswer((_) async => [tPetModel]);

      // act
      final result = await repository.getAvailablePets('available');

      // assert
      expect(result, [tPet]);
      verify(mockRemoteDataSource.getAvailablePets('available')).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('createPet should call remote data source', () async {
      // arrange
      when(mockRemoteDataSource.createPet(any)).thenAnswer((_) async => null);

      // act
      await repository.createPet(tCreateRequest);

      // assert
      verify(mockRemoteDataSource.createPet(tCreateRequest)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('updatePet should call remote data source', () async {
      // arrange
      when(mockRemoteDataSource.updatePet(any)).thenAnswer((_) async => null);

      // act
      await repository.updatePet(tUpdateRequest);

      // assert
      verify(mockRemoteDataSource.updatePet(tUpdateRequest)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('deletePet should call remote data source', () async {
      // arrange
      when(mockRemoteDataSource.deletePet(any)).thenAnswer((_) async => null);

      // act
      await repository.deletePet(1);

      // assert
      verify(mockRemoteDataSource.deletePet(1)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('getAvailablePets should throw exception if remote fails', () async {
      // arrange
      when(
        mockRemoteDataSource.getAvailablePets(any),
      ).thenThrow(Exception('Failed to fetch'));

      // act & assert
      await expectLater(
        () async => await repository.getAvailablePets('available'),
        throwsA(isA<Exception>()),
      );
      verify(mockRemoteDataSource.getAvailablePets('available')).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
