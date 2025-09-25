import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petstore_app/features/admin/domain/usecases/create_pet.dart';
import 'package:petstore_app/features/pet/data/models/pet_create_request_model.dart';

import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

// Generate a mock for PetRepository
@GenerateMocks([PetRepository])
import 'create_pet_test.mocks.dart';

void main() {
  late CreatePet usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = CreatePet(mockRepository);
  });

  group('CreatePet UseCase', () {
    final tRequest = PetCreateRequest(
      id: 1,
      name: 'Doggo',
      status: 'available',
      categoryId: 1,
      categoryName: 'Dogs',
      photoUrl: 'string',
    );

    test('should call repository to create pet successfully', () async {
      // arrange
      when(mockRepository.createPet(any)).thenAnswer((_) async => null);

      // act
      await usecase(tRequest);

      // assert
      verify(mockRepository.createPet(tRequest)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository fails', () async {
      // arrange
      when(
        mockRepository.createPet(any),
      ).thenThrow(Exception('Failed to create pet'));

      // act & assert
      await expectLater(
        () async => await usecase(tRequest),
        throwsA(isA<Exception>()),
      );

      verify(mockRepository.createPet(tRequest)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
