import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/constants/color_constants.dart';

/// Вывод индикатора загрузки даных
class ProgressDotsIndicator extends StatefulWidget {
  const ProgressDotsIndicator({super.key});

  @override
  State<ProgressDotsIndicator> createState() => _ProgressDotsIndicatorState();
}

class _ProgressDotsIndicatorState extends State<ProgressDotsIndicator>
    with SingleTickerProviderStateMixin {
  /// Контроллер анимации
  late AnimationController _controller;

  /// Начальная точка индикатора
  var currentDots = 0;

  @override
  void initState() {
    super.initState();

    /// Инициализируем контроллер анимации с одновременным запуском
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 3,
      duration: const Duration(milliseconds: 700),
    )..repeat();
    _controller.addListener(
      () {
        setState(() {
          currentDots = _controller.value.toInt();
        });
      },
    );
  }

  @override
  void dispose() {
    /// Уничтожаем контроллер
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Цвет точки индикатора
    const colorDot = ColorConstants.textAnswer;

    /// Форма точки
    final rectangleRadius =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));
    return DotsIndicator(
      /// Прогресс выглядит как попеременно меняющиеся 3 точки
      dotsCount: 3,
      position: currentDots,
      decorator: DotsDecorator(
        color: colorDot,
        activeColor: colorDot,
        size: const Size.square(10),
        activeSize: const Size.square(16),
        shape: rectangleRadius,
        activeShape: rectangleRadius,
      ),
    );
  }
}
