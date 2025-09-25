import '../entities/order.dart';
import '../repositories/order_repository.dart';

class PlaceOrder {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  Future<Order> call(Order order) {
    return repository.placeOrder(order);
  }
}
