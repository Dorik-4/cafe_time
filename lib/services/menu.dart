import 'dart:convert';

import 'package:cafe_time/widgets/product_card.dart';
import 'package:dio/dio.dart';

Future<List<String>> fetchCategories() async {
  const String apiUrl = 'https://hackers54.ru:4433/api/v1.0/static_data/category';
  final Dio dio = Dio();

  try {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final data = response.data;

      List<String> categories = ['Все'];

      categories.addAll(
        (data['categories'] as List)
            .map<String>((category) => category['title'] as String)
            .toList(),
      );

      return categories;
    } else {
      throw Exception('Ошибка при получении данных');
    }
  } catch (e) {
    throw Exception('Не удалось подключиться к API: $e');
  }
}


Future<List<ProductItem>> fetchMenu() async {
  const String apiUrl = 'https://hackers54.ru:4433/api/v1.0/static_data/menu';
  final Dio dio = Dio();

  try {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final data = response.data;

      List<dynamic> productsJson = data["products"];
      return productsJson.map((json) => ProductItem.fromJson(json)).toList();

    } else {
      throw Exception('Ошибка при получении данных');
    }
  } catch (e) {
    throw Exception('Не удалось подключиться к API: $e');
  }
}
