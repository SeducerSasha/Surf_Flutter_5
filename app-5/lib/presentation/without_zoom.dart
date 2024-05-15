import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/constants/color_constants.dart';
import 'package:surf_flutter_courses_template/constants/text_constants.dart';

/// Вывод текста внизу шара
class TextWithoutZomm extends StatelessWidget {
  const TextWithoutZomm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 56),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          TextConstants.textOnStart,
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorConstants.textLabel),
        ),
      ),
    );
  }
}
