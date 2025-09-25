import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petstore_app/features/pet/domain/entities/order.dart';

import 'package:petstore_app/features/pet/domain/repositories/order_repository.dart';
import 'package:petstore_app/features/pet/domain/usecases/place_order.dart';

// Generate a mock class for OrderRepository
@GenerateMocks([OrderRepository])
import 'place_order_test.mocks.dart';

void main() {
  late PlaceOrder usecase;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    usecase = PlaceOrder(mockOrderRepository);
  });

  group('PlaceOrder UseCase', () {
    final tOrder = Order(
      id: 1,
      petId: 10,
      quantity: 2,
      shipDate: "2025-09-23T12:00:00.000Z",
      status: "placed",
      complete: true,
    );

    test('should place order successfully', () async {
      // arrange
      when(mockOrderRepository.placeOrder(any)).thenAnswer((_) async => tOrder);

      // act
      final result = await usecase(tOrder);

      // assert
      expect(result, equals(tOrder));
      verify(mockOrderRepository.placeOrder(tOrder));
      verifyNoMoreInteractions(mockOrderRepository);
    });

    test('should throw an exception when repository fails', () async {
      // arrange
      when(
        mockOrderRepository.placeOrder(any),
      ).thenThrow(Exception('Failed to place order'));

      // act & assert
      await expectLater(
        () async => await usecase(tOrder),
        throwsA(isA<Exception>()),
      );

      verify(mockOrderRepository.placeOrder(tOrder)).called(1);
      verifyNoMoreInteractions(mockOrderRepository);
    });
  });
}
