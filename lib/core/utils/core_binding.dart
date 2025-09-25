import 'package:get/get.dart';
import 'package:petstore_app/core/network/dio_client.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DioClient(), fenix: true);
  }
}
