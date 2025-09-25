import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petstore_app/features/admin/domain/usecases/delete_pet.dart';

import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

// Generate a mock for PetRepository
@GenerateMocks([PetRepository])
import 'delete_pet_test.mocks.dart';

void main() {
  late DeletePet usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = DeletePet(mockRepository);
  });

  group('DeletePet UseCase', () {
    final tId = 1;

    test('should call repository to delete pet successfully', () async {
      // arrange
      when(mockRepository.deletePet(any)).thenAnswer((_) async => null);

      // act
      await usecase(tId);

      // assert
      verify(mockRepository.deletePet(tId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository fails', () async {
      // arrange
      when(
        mockRepository.deletePet(any),
      ).thenThrow(Exception('Failed to delete pet'));

      // act & assert
      await expectLater(
        () async => await usecase(tId),
        throwsA(isA<Exception>()),
      );

      verify(mockRepository.deletePet(tId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
