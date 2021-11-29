import 'package:dio/dio.dart';

class DioClient {
  static const BASE_URL_DEV = "";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: BASE_URL_DEV,
    connectTimeout: 30000,
    receiveTimeout: 20000,
    //headers:{"access-token": someKey}
  );
  static final DioClient _dioClient = DioClient._internal();
  Dio _dio = new Dio(baseOptions);

  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
