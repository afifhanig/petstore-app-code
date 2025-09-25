import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({String baseUrl = 'https://petstore3.swagger.io/api/v3'})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
}
