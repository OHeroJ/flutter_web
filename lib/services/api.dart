import 'package:dio/dio.dart';

class Api {
  static const endpoint = 'https://hello.loveli.site';

  final client = Dio()..interceptors.add(LogInterceptor(responseBody: true));
}
