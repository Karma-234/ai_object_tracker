import 'package:flutter/material.dart';

extension StringExtension on String {
  String get png => "assets/images/$this.png";
  String get txt => "assets/models/mobilenet_v1_1.0_224.txt";
  String get lite => "assets/models/mobilenet_v1_1.0_224.tflite";

  capitalizeFirstLetter() =>
      isEmpty ? this : replaceRange(0, 1, this[0].toUpperCase());

  sentenceCase() {
    var newString = this[0].toUpperCase();
    return replaceRange(0, 1, newString);
  }
}

extension Gap on num {
  Widget get h => SizedBox(
        height: toDouble(),
      );
  Widget get w => SizedBox(
        width: toDouble(),
      );
}
