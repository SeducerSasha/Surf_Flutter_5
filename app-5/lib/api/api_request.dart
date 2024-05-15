import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surf_flutter_courses_template/model/data.dart';

/// Получение ответов шара
class DataResponseBall {
  Future<DataResponse> getResponse() async {
    /// Получение JSON с сайта
    final response = await _loadJson();

    /// Искусственная задержка, а то ответ приходит очень быстро
    await Future.delayed(const Duration(seconds: 3));

    return DataResponse.fromJson(response);
  }

  Future<String> _loadJson() async {
    /// Адрес сайта получения ответов магического шара.
    const url = 'https://eightballapi.com/api';

    /// Отправка запроса на сервер и получение результата.
    final response = await http.get(Uri.parse(url));

    /// Обработка статусов ответа сервера.
    switch (response.statusCode) {
      case 200:
        final decoded = jsonDecode(response.body);
        if (decoded['reading'] != '') {
          return response.body;
        } else {
          return '';
        }
      case >= 500:
        throw 'Ошибка сервера';
      case >= 400 && < 500:
        throw 'Ошибка клиента';
      default:
        throw Exception('Неизвестная ошибка');
    }
  }
}
