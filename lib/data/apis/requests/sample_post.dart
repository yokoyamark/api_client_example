import 'package:api_client_example/data/apis/requests/request.dart';

import '../http_method.dart';

class SamplePost extends Request {
  @override
  HTTPMethod method = HTTPMethod.post;

  @override
  String path = '/post';

  @override
  Future<Map<String, dynamic>> body() async {
    return {
      'test': 'body',
    };
  }
}
