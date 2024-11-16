import 'dart:ffi';

import 'package:flutter/material.dart';


class ProductItem {
  final int id;
  final String title;
  final String description;
  final String extraInfo;
  final String photoUrl;
  final int price;
  final int idCategory;
  final bool special;


  ProductItem({
    required this.id,
    required this.title,
    required this.price,
    required this.idCategory,
    this.description = "",
    this.extraInfo = "",
    required this.photoUrl,
    this.special = false,

  });

  factory ProductItem.fromJson(Map<String, dynamic> json){
    return ProductItem(
        id: json['id'],
        title: json['title'] ,
        price: json['price'] ,
        idCategory: json['id_category'],
        photoUrl: json ['photo_url'],
        description: json['description'],
        extraInfo: json['extra_info'],
        special: json['isSpecial'],
    )
  }

}


class ProductCard extends StatelessWidget {
  final ProductItem item;

  const ProductCard({
   super.key,
   required this.item,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(item.photoUrl, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'Цена: ${item.price}'} руб.',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
