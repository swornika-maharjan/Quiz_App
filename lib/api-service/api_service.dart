import 'package:dio/dio.dart';
import 'package:quizzie/utils/domains.dart';

class RESTExecutor {
  static String? _token;

  final String domain;
  final String label;
  final String method;
  final Map<String, dynamic>? params; // query parameters
  final Function(dynamic data) successCallback;
  final Function(dynamic error) errorCallback;

  RESTExecutor({
    required this.domain,
    required this.label,
    required this.method,
    this.params,
    required this.successCallback,
    required this.errorCallback,
  });

  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: "http://10.0.2.2:8080/api/",
        connectTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
        headers: {
          "Content-Type": "application/json",
          if (_token != null) "Authorization": "Bearer $_token",
        },
      ),
    );
  }

  String get endpoint {
    if (!domains.containsKey(domain)) {
      throw Exception("Domain '$domain' not found");
    }
    final domainMap = domains[domain]!;
    if (!domainMap.containsKey(label)) {
      throw Exception("Label '$label' not found under domain '$domain'");
    }
    return domainMap[label]!;
  }

  /// Executes the request
  /// [data] is the request body (for POST, PUT, DELETE)
  Future<void> execute({Map<String, dynamic>? data}) async {
    final Dio dio = _createDio();

    try {
      Response response;

      switch (method.toUpperCase()) {
        case "GET":
          // GET uses query parameters only
          response = await dio.get(endpoint, queryParameters: params);
          break;

        case "POST":
          response =
              await dio.post(endpoint, queryParameters: params, data: data);
          break;

        case "PUT":
          response =
              await dio.put(endpoint, queryParameters: params, data: data);
          break;

        case "DELETE":
          response =
              await dio.delete(endpoint, queryParameters: params, data: data);
          break;

        default:
          throw Exception("Unsupported HTTP method");
      }

      successCallback(response.data);
    } catch (error) {
      if (error is DioException) {
        errorCallback(error.response?.data ?? error.message);
      } else {
        errorCallback(error.toString());
      }
    }
  }

  // Token management
  static void setToken(String token) => _token = token;
  static void clearToken() => _token = null;
  static String? getToken() => _token;
}
