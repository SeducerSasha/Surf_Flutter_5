import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_flutter_courses_template/api/api_request.dart';
import 'package:surf_flutter_courses_template/constants/color_constants.dart';
import 'package:surf_flutter_courses_template/constants/text_constants.dart';
import 'package:surf_flutter_courses_template/model/data.dart';
import 'package:surf_flutter_courses_template/presentation/progress_indicator.dart';

/// Вывод ответа шара
class GetAnAnswer extends StatelessWidget {
  const GetAnAnswer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// Отправляем запрос на сайт
    final Future<DataResponse> answer = DataResponseBall().getResponse();
    return FutureBuilder(
      future: answer,
      builder: (_, snapshot) {
        /// Если данных еще нет - выводим индикатор загрузки
        if (!snapshot.hasData) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: ProgressDotsIndicator(),
            ),
          );
        } else {
          /// Если пришел ответ - показываем его на шаре.
          /// Текст локализован в зависимости от системного языка.
          final textResult =
              snapshot.data?.responseBall.tr() ?? TextConstants.textError.tr();

          return ShowAnswer(textResult: textResult);
        }
      },
    );
  }
}

/// Показываем ответ при помощи анимации
class ShowAnswer extends StatefulWidget {
  const ShowAnswer({
    super.key,
    required this.textResult,
  });

  final String textResult;

  @override
  State<ShowAnswer> createState() => _ShowAnswerState();
}

class _ShowAnswerState extends State<ShowAnswer>
    with SingleTickerProviderStateMixin {
  /// Контроллер анимации
  late AnimationController _controller;

  /// Анимация будет путем изменения прозрачности от 0 до 1
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// Инициализация контроллера
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    /// Определяем изменение анимации от 0 до 1
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    /// Уничтожаем контроллер
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isErrorText = widget.textResult == TextConstants.textError.tr();
    Color colorText = ColorConstants.textAnswer;
    TextStyle textStyle = TextStyle(fontSize: 56, color: colorText);
    if (isErrorText) {
      colorText = ColorConstants.textError;
      textStyle = TextStyle(fontSize: 56, color: colorText);
    }

    /// Запускаем анимацию прозрачности выводимого текста
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.textResult,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
