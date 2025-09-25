import 'package:dio/dio.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<OrderModel> placeOrder(OrderModel order) async {
    final response = await dio.post('/store/order', data: order.toJson());
    return OrderModel.fromJson(response.data);
  }
}
