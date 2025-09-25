import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Order> placeOrder(Order order) async {
    final model = OrderModel(
      id: order.id,
      petId: order.petId,
      quantity: order.quantity,
      shipDate: order.shipDate,
      status: order.status,
      complete: order.complete,
    );
    return await dataSource.placeOrder(model);
  }
}
