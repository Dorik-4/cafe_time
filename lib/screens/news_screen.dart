import 'package:flutter/material.dart';
import '../common_gradient.dart';
import '../main.dart';

class NewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> news = [
    {
      'title': 'Новость 1',
      'text': 'Это описание первой новости, которое будет отображаться на экране...',
      'imageUrl': 'https://example.com/news1.jpg',
      'category': 'Кофе',
      'productId': 20,
    },
    {
      'title': 'Акция на кофе',
      'text': 'Специальное предложение на кофе, скидки до 50%...',
      'imageUrl': 'https://example.com/news2.jpg',
      'category': 'Кофе',
    },
    {
      'title': 'Новость 3',
      'text': 'Это еще одно описание новости для проверки отображения...',
      'imageUrl': 'https://example.com/news3.jpg',
      'category': 'Чай',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новости и акции')),
      body: Container(
        decoration: commonGradientBackground(),
        child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final newsItem = news[index];
            return GestureDetector(
              onTap: () {
                _handleCardTap(context, newsItem);
              },
              child: Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (newsItem['imageUrl'] != null)
                        Image.network(newsItem['imageUrl'], height: 200, fit: BoxFit.cover),
                      SizedBox(height: 8),
                      Text(
                        newsItem['title'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _shortenText(newsItem['text']),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          newsItem.containsKey('productId')
                              ? 'Нажмите, чтобы перейти к товару'
                              : 'Нажмите, чтобы перейти к категории',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _shortenText(String text) {
    return text.length > 50 ? text.substring(0, 50) + '...' : text;
  }

  void _handleCardTap(BuildContext context, Map<String, dynamic> newsItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          category: newsItem['category'],
          productId: newsItem['productId'],
        ),
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  NewsDetailScreen({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(newsItem['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsItem['imageUrl'] != null)
              Image.network(newsItem['imageUrl'], height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              newsItem['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              newsItem['text'],
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
