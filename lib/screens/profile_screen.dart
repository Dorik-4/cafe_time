import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Пакет для выбора изображения
import '../common_gradient.dart';  // Подключаем общий градиент

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Сергей';  // Имя пользователя
  String _phoneNumber = '+7 917 999-99-99';  // Номер телефона
  String? _selectedDrink;  // Любимый напиток
  int _discount = 10;  // Процент скидки
  String _profileImagePath = 'assets/profile.jpg';  // Путь к фотографии профиля по умолчанию
  final List<String> _drinks = ['Капучино', 'Латте', 'Эспрессо', 'Американо'];  // Список напитков

  // Функция для выбора новой фотографии профиля
  Future<void> _changeProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);  // Выбираем из галереи

    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;  // Устанавливаем новый путь к фотографии
      });
    }
  }

  // Функция для редактирования имени
  void _editName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String _tempName = _name;
        return AlertDialog(
          title: const Text('Изменить имя'),
          content: TextField(
            onChanged: (value) {
              _tempName = value;
            },
            decoration: const InputDecoration(hintText: "Введите новое имя"),
          ),
          actions: [
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Сохранить'),
              onPressed: () {
                setState(() {
                  _name = _tempName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: commonGradientBackground(),  // Применяем общий градиент
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Строка с фотографией и текстом (имя и телефон)
              Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Фотография пользователя
                  GestureDetector(
                    onTap: () => _changeProfileImage(),  // При нажатии выбор новой фотографии
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(_profileImagePath),  // Путь к изображению
                    ),
                  ),
                  const SizedBox(width: 20),  // Отступ между фотографией и текстом
                  // Имя пользователя и номер телефона
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _name,
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: _editName,  // Открываем диалог редактирования имени
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _phoneNumber,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Любимый напиток
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Любимый напиток', style: TextStyle(color: Colors.white)),
                    DropdownButtonFormField<String>(
                      value: _selectedDrink,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDrink = newValue;
                        });
                      },
                      items: _drinks.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Процент скидки
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('% Скидки', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    Text(
                      '$_discount%',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Spacer(),
              // Кнопка выхода из аккаунта
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');  // Возвращаемся на экран авторизации
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.red,  // Цвет кнопки выхода
                ),
                child: const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
