import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:surf_flutter_courses_template/constants/color_constants.dart';
import 'package:surf_flutter_courses_template/constants/text_constants.dart';
import 'package:surf_flutter_courses_template/presentation/text_answer.dart';
import 'package:surf_flutter_courses_template/presentation/without_zoom.dart';

/// Главный экран.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// Устанавливаем прозрачный цвет, чтобы при увеличении шара ничего не мешало
      backgroundColor: Colors.transparent,
      body: BodyScreenBall(),
    );
  }
}

class BodyScreenBall extends StatefulWidget {
  const BodyScreenBall({
    super.key,
  });

  @override
  State<BodyScreenBall> createState() => _BodyScreenBallState();
}

class _BodyScreenBallState extends State<BodyScreenBall>
    with SingleTickerProviderStateMixin {
  /// Контроллер анимации
  late AnimationController _controller;

  /// Маштаб изображения шара
  var scaleBall = 1.0;

  /// Признак увеличения шара
  bool zoomed = false;

  @override
  void initState() {
    super.initState();

    /// Инициализация отслеживания встряхивания телефона
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        zoomed = !zoomed;
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward(from: 0.0);
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    /// Инициализация контроллера увеличения изображения шара от 1 до 2.8
    _controller = AnimationController(
        vsync: this,
        lowerBound: scaleBall,
        upperBound: 2.8,
        duration: const Duration(milliseconds: 300));
    _controller.addListener(() {
      setState(() {
        scaleBall = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    /// Уничтожаем контроллер
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            /// Чтобы картинка шара не выделялась на экране, формируем градиентную заливку
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstants.topScaffold,
                ColorConstants.bottomScaffold
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () {
              /// При нажатии на шаре включаем анимацию увеличения шара
              zoomed = !zoomed;
              if (_controller.isCompleted) {
                _controller.reverse();
              } else {
                _controller.forward(from: 0.0);
              }
            },
            child: Transform.scale(
              /// Вывод картинки
              scale: scaleBall,
              child: Image.asset(
                TextConstants.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        /// Если шар не увеличен - выводим надпись внизу
        /// Если нажали на шар - выводим анимацию загрузки перед показом ответа
        zoomed ? const GetAnAnswer() : const TextWithoutZomm(),
      ],
    );
  }
}
