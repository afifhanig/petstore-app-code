import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petstore_app/features/pet/domain/entities/pet.dart';
import 'package:petstore_app/features/pet/domain/usecases/get_available_pets.dart';
import 'package:petstore_app/features/pet/domain/repositories/pet_repository.dart';

// 🔹 Generate mock class for PetRepository
@GenerateMocks([PetRepository])
import 'get_available_pets_test.mocks.dart';

void main() {
  late GetAvailablePets usecase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    usecase = GetAvailablePets(mockRepository);
  });

  group('GetAvailablePets UseCase', () {
    test('should return list of pets when repository returns data', () async {
      // arrange
      const status = "available";
      final pets = [
        Pet(
          id: 1,
          name: 'Doggo',
          status: 'available',
          categoryName: 'Dogs',
          photoUrl: null,
        ),
        Pet(
          id: 2,
          name: 'Kitty',
          status: 'available',
          categoryName: 'Cats',
          photoUrl: null,
        ),
      ];

      when(
        mockRepository.getAvailablePets(status),
      ).thenAnswer((_) async => pets);

      // act
      final result = await usecase(status);

      // assert
      expect(result, pets);
      verify(mockRepository.getAvailablePets(status)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when repository returns no data', () async {
      // arrange
      const status = "sold";
      when(mockRepository.getAvailablePets(status)).thenAnswer((_) async => []);

      // act
      final result = await usecase(status);

      // assert
      expect(result, isEmpty);
      verify(mockRepository.getAvailablePets(status)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
