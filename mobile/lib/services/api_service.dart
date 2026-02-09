import 'package:dio/dio.dart';

/// Service API pour communiquer avec le backend Django
class ApiService {
  late final Dio _dio;
  
  // URL du backend Django
  static const String baseUrl = 'http://localhost:8000/api';
  
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    // Intercepteur pour logger les requêtes
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
  
  /// GET request
  Future<Response> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// POST request
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// PUT request
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// DELETE request
  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Authentification JWT
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/token/',
        data: {
          'username': username,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  /// Définir le token JWT
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  /// Supprimer le token JWT
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
  
  /// Gestion des erreurs
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Délai de connexion dépassé';
      case DioExceptionType.badResponse:
        return 'Erreur serveur: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Requête annulée';
      default:
        return 'Erreur de connexion au serveur';
    }
  }
}
