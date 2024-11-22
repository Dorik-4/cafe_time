import 'package:flutter/material.dart';
import '../common_gradient.dart';
import '../main.dart';

class NewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> news = [
    {
      'title': 'Бодрая рабочая неделя',
      'text': 'С 7:00 по 10:00 действует скидка 15% на любой кофе для студентов и школьшиков',
      'imageUrl': 'https://www.mos.ru/upload/newsfeed/newsfeed/PYLS_vakansiiivanko.jpg',
      'category': 'Горячие напитки',
      'productId': 3,
    },
    {
      'title': 'Акция на кофе',
      'text': 'Специальное предложение на кофе, при покупке 5 больших кофе - скидки до 50%',
      'imageUrl': 'https://avatars.mds.yandex.net/i?id=f2f37ccbb5b0df4d60bbc90b2bd045ca_l-4919870-images-thumbs&n=13',
      'category': 'Горячие напитки',
      'productId': 3,
    },
    {
      'title': 'Приятный обед',
      'text': 'Уделите время на бизнес ланч "Трудоголик" стоимостью от 350 рублей',
      'imageUrl': 'https://static-actual-production.chibbis.ru/049ca2d0562d0736ab4b76acb5683ba5.jpeg',
      'category': 'Суп',
      'productId': 2,
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
