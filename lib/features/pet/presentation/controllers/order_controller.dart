import 'package:get/get.dart';
import 'package:petstore_app/features/pet/domain/entities/order.dart';
import 'package:petstore_app/features/pet/domain/usecases/place_order.dart';
import 'package:petstore_app/routes/app_routes.dart';

class OrderController extends GetxController {
  final PlaceOrder placeOrderUsecase;

  OrderController(this.placeOrderUsecase);

  var isLoading = false.obs;
  var orderResult = Rxn<Order>();
  var errorMessage = RxnString();

  Future<void> createOrder(Order order) async {
    isLoading.value = true;
    errorMessage.value = null;
    orderResult.value = null;

    try {
      if (order.quantity == null || order.quantity! <= 0) {
        errorMessage.value = "Quantity must be greater than zero.";
        isLoading.value = false;
        return;
      }
      final result = await placeOrderUsecase(order);
      Get.offNamed(
        AppRoutes.orderSuccess,
        arguments: {"orderId": result.petId, "orderQty": result.quantity},
      );
    } catch (e) {
      errorMessage.value = "Failed to place order: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
