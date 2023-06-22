import 'package:flutter/material.dart';

class AppTextStyles {
  static const characterName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const status = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

  static const lastLocation = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );

  static const firstLocation = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis);

  static const episodes = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  static const text = TextStyle(
    fontSize: 15,
  );
}

//вынесенные в отдельный класс стили всех текстовых элементов