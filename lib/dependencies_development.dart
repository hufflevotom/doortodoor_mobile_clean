part of 'main_development.dart';

// Dio
final _dio = Dio(
  BaseOptions(
    baseUrl: 'https://doortodoor-backend.hufflevotom.com',
    validateStatus: (status) => (status ?? 500) < 500,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  ),
);

// Repositories
final AuthRepository authRepository = HttpAuthRepository(_dio);
final FoliosRepository foliosRepository = HttpFoliosRepository(_dio);

// Interceptors
void configDio() {
  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        log('*** ${options.uri.toString()} ***');
        log('httpRequest - data: ${options.data}');
        log('httpRequest - headers: ${options.headers}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        log('*** ${response.realUri.toString()} ***');
        log('httpResponse - statusCode: ${response.statusCode}');
        log('httpResponse - response: ${response.data}');
        handler.next(response);
      },
      onError: (e, handler) {
        log('*** ${e.requestOptions.uri.toString()} ***');
        log('httpError: $e');
        handler.next(e);
      },
    ),
  );
}
