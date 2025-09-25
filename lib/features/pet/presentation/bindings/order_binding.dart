import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/place_order.dart';
import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // Data
    Get.lazyPut<OrderRemoteDataSource>(
      () => OrderRemoteDataSource(Get.find<DioClient>().dio),
    );
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find()));

    // Domain
    Get.lazyPut(() => PlaceOrder(Get.find()));

    // Presentation
    Get.lazyPut(() => OrderController(Get.find()));
  }
}
