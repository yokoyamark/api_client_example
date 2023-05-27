import 'dart:convert';

import 'package:api_client_example/data/apis/requests/request.dart';
import 'package:http/http.dart' as http;

class ApiCore {
  final http.Client _client = http.Client();
  final Duration _timeLimit = const Duration(seconds: 30);

  Future<http.Response> send(http.Request req) async {
    return http.Response.fromStream(
        await _client.send(req).timeout(_timeLimit));
  }
}

class ApiClient {
  final api = ApiCore();

  Future<http.Response> execute(Request req) async {
    final http.Request request = await _build(req);
    try {
      final response = await api.send(request);
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
    // Business Logic
    return Exception({res.body});
  }
}
