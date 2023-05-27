import 'package:api_client_example/data/apis/requests/request.dart';

import '../http_method.dart';

class SampleGet extends Request {
  @override
  HTTPMethod method = HTTPMethod.get;

  @override
  String path = '/get';

  @override
  Future<Map<String, String>> query() async {
    return {
      'test': 'query',
    };
  }
}
