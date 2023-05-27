import 'dart:convert';

import 'package:api_client_example/data/apis/requests/request.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client = http.Client();
  final Duration _timeLimit = const Duration(seconds: 30);

  Future<http.Response> execute(Request req) async {
    final http.Request request = await _build(req);
    try {
      final response = await http.Response.fromStream(
          await _client.send(request).timeout(_timeLimit));
      if (200 <= response.statusCode && response.statusCode <= 299) {
        return response;
      } else {
        throw _createException(response);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<http.Request> _build(Request req) async {
    final Map<String, String> headers = await req.headers();
    final Map<String, String> query = await req.query();
    final Map<String, dynamic> body = await req.body();

    Uri url = Uri.https(req.domain, req.path, query);

    return http.Request(req.method.name.toUpperCase(), url)
      ..headers.addAll(headers)
      ..body = json.encode(body);
  }

  Exception _createException(http.Response res) {
    // なんかしら業務エラー
    return Exception({res.body});
  }
}
