import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/news_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';
import 'common_gradient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кафе',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',  // Начальный маршрут - экран авторизации
      routes: {
        '/': (context) => LoginScreen(), // Экран авторизации
        '/home': (context) => HomeScreen(), // Главная страница с навигацией
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String? category;
  final int? productId;

  const HomeScreen({this.category, this.productId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;  // По умолчанию выбран экран меню

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Передаем категорию и productId на экран меню
    _screens = [
      ProfileScreen(),
      NewsScreen(),
      MenuScreen(category: widget.category, productId: widget.productId),
      BookingsScreen(),
      CartScreen(),
    ];
    // Если есть переданная категория или productId, устанавливаем экран меню как активный
    if (widget.category != null || widget.productId != null) {
      _currentIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: commonGradientBackground(),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 35),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article, size: 35),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.brown,
                child: Icon(Icons.local_cafe, size: 25, color: Colors.white),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 35),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 35),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
