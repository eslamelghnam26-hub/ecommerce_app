import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/auth_service.dart';
import 'package:ecommerce_app/core/utils/app_constants.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;

class ApiClient extends GetxService {
  late Dio dio;
  final AuthService _authService;

  ApiClient(this._authService) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _authService.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          handler.next(e);
        },
      ),
    );
  }

  void _handleUnauthorized() {
    _authService.logout();
    Get.offAllNamed('/login');
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> upload(
    String path, {
    required List<MultipartFile> files,
    dynamic data,
  }) async {
    try {
      final formData = FormData();
      for (var file in files) {
        formData.files.add(MapEntry('images[]', file));
      }
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }
      final response = await dio.post(
        path,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('timeout');
      case DioExceptionType.connectionError:
        return Exception('connection_error');
      default:
        final message = e.response?.data['message'] ?? 'Something went wrong';
        return Exception(message);
    }
  }
}
