import 'package:flutter/material.dart';

// Функция для общего градиента
BoxDecoration commonGradientBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue[800]!, Colors.grey[800]!], // Градиентный фон
    ),
  );
}
