import 'package:flutter/material.dart';

String getPathForImage(imagePathFormat, fileName) {
  try {
    new Image.asset(
      imagePathFormat + fileName + '.png',
      height: 20,
      width: 20,
    );
    return imagePathFormat + fileName + '.png';
  } catch (Exception) {
    return 'assets/languages/fake.png';
  }
}
