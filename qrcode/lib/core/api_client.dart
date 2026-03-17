import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.gift-system.com',
    connectTimeout: const Duration(seconds: 5), 
  ));
}