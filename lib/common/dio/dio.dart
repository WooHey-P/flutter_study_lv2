import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../const/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      options.headers.addAll({
        'authorization': 'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}'
      });
    }
    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      options.headers.addAll({
        'authorization': 'Bearer ${await storage.read(key: REFRESH_TOKEN_KEY)}'
      });
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refresh token이 없으면 에러 생성
    if (refreshToken == null) {
      // 에러 생성
      return handler.reject(err);
    }

    final isStatusCode401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatusCode401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post('http://$ip/auth/token', options: Options(
            headers: {
                'authorization': 'Bearer $refreshToken'
              }
          ));
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $accessToken'
        });
        // 갱신된 토큰 저장
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        // 갱신된 토큰으로 변경 후 재요청
        final response = await dio.fetch(options);
        // 에러 없이 요청 끝냄
        return handler.resolve(response);
      }on DioError catch (e) {
        // 잘못된 토큰
        return handler.reject(e);
      }
    }

    return super.onError(err, handler);
  }
}