import 'package:api_client_example/data/apis/constant.dart';
import 'package:api_client_example/data/apis/http_method.dart';

abstract class Request {
  String domain = Constant.domain;

  abstract String path;

  abstract HTTPMethod method;

  Future<Map<String, String>> headers() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, String>> query() async => {};

  Future<Map<String, dynamic>> body() async => {};
}
