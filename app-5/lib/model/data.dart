import 'dart:convert';

/// Модель получаемых данных с сайта
class DataResponse {
  final String responseBall;
  const DataResponse({
    required this.responseBall,
  });

  factory DataResponse.fromMap(Map<String, dynamic> map) {
    return DataResponse(
      responseBall: (map["reading"] ?? '') as String,
    );
  }

  factory DataResponse.fromJson(String source) =>
      DataResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
