import 'package:dio/dio.dart';

class EntityRequest {
  final Dio dio;
  final String entity;
  final Map<String, dynamic> _filters = {};
  int? _limit;
  int? _page;
  List<String>? _fields;
  String? _sort;

  EntityRequest({required this.dio, required this.entity});

  EntityRequest where(Map<String, dynamic> filters) {
    filters.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        value.forEach((operator, val) {
          _filters['$key[$operator]'] = val; // Correct interpolation
        });
      } else {
        _filters[key] = value;
      }
    });
    return this;
  }

  EntityRequest limit(int limit) {
    _limit = limit;
    return this;
  }

  EntityRequest page(int page) {
    _page = page;
    return this;
  }

  EntityRequest select(List<String> fields) {
    _fields = fields;
    return this;
  }

  EntityRequest orderBy(String field) {
    _sort = field;
    return this;
  }

  Future<List<dynamic>> get() async {
    final queryParams = <String, dynamic>{};
    _filters.forEach((key, value) {
      queryParams['filter[$key]'] = value; // Corrected
    });

    if (_limit != null) queryParams['limit'] = _limit;
    if (_page != null) queryParams['page'] = _page;
    if (_fields != null) queryParams['fields'] = _fields;
    if (_sort != null) queryParams['sort'] = _sort;

    try {
      final response = await dio.get('/$entity', queryParameters: queryParams); // Corrected
      return response.data['data'];
    } on DioException catch (e) {
      throw Exception("API error: ${e.response?.data}");
    }
  }

  Future<List<T>> getTyped<T>(T Function(Map<String, dynamic>) fromJson) async {
    final queryParams = <String, dynamic>{};
    _filters.forEach((key, value) {
      queryParams['filter[$key]'] = value;
    });

    if (_limit != null) queryParams['limit'] = _limit;
    if (_page != null) queryParams['page'] = _page;
    if (_fields != null) queryParams['fields'] = _fields;
    if (_sort != null) queryParams['sort'] = _sort;

    final response = await dio.get('/$entity', queryParameters: queryParams); // Corrected
    final data = response.data['data'] as List;
    return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<dynamic> getOne(String id) async {
    final response = await dio.get('/$entity/$id'); // Corrected
    return response.data['data'];
  }

  Future<dynamic> create(Map<String, dynamic> data) async {
    final response = await dio.post('/$entity', data: data); // Corrected
    return response.data['data'];
  }

  Future<dynamic> update(String id, Map<String, dynamic> data) async {
    final response = await dio.patch('/$entity/$id', data: data); // Corrected
    return response.data['data'];
  }

  Future<void> delete(String id) async {
    await dio.delete('/$entity/$id'); // Corrected
  }
}
