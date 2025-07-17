
import 'package:dio/dio.dart';
import 'entity_request.dart';

class ApsoClient {
  final Dio dio;
  final String baseUrl;

  ApsoClient({required this.baseUrl, required String apiKey})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'x-api-key': apiKey},
        ));

  EntityRequest entity(String entityName) {
    return EntityRequest(dio: dio, entity: entityName);
  }
}
