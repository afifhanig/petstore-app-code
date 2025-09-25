import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petstore_app/features/admin/domain/usecases/update_pet.dart';
import 'package:petstore_app/features/pet/data/models/pet_update_request_model.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

// Generate a mock for PetRepository
@GenerateMocks([PetRepository])
import 'update_pet_test.mocks.dart';

void main() {
  late UpdatePet usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = UpdatePet(mockRepository);
  });

  group('UpdatePet UseCase', () {
    final tRequest = PetUpdateRequest(
      id: 1,
      name: 'Doggo Updated',
      status: 'available',
      categoryId: 1,
      categoryName: 'Dogs',
      photoUrl: 'string',
    );

    test('should call repository to update pet successfully', () async {
      // arrange
      when(mockRepository.updatePet(any)).thenAnswer((_) async => null);

      // act
      await usecase(tRequest);

      // assert
      verify(mockRepository.updatePet(tRequest)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository fails', () async {
      // arrange
      when(
        mockRepository.updatePet(any),
      ).thenThrow(Exception('Failed to update pet'));

      // act & assert
      await expectLater(
        () async => await usecase(tRequest),
        throwsA(isA<Exception>()),
      );

      verify(mockRepository.updatePet(tRequest)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
