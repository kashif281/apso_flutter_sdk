
import 'package:flutter_test/flutter_test.dart';
import 'package:apso_flutter_sdk/apso_client.dart';

void main() {
  test('ApsoClient initializes with given values', () {
    final client = ApsoClient(baseUrl: 'https://api.example.com', apiKey: '123');
    expect(client.baseUrl, 'https://api.example.com');
    expect(client.dio.options.headers['x-api-key'], '123');
  });
}
