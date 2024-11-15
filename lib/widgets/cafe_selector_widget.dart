import 'package:flutter/material.dart';

class CafeSelectorWidget extends StatefulWidget {
  final String? selectedCafe;
  final Function(String) onCafeSelected;  // Логика для выбора кофейни

  CafeSelectorWidget({required this.selectedCafe, required this.onCafeSelected});

  @override
  _CafeSelectorWidgetState createState() => _CafeSelectorWidgetState();
}

class _CafeSelectorWidgetState extends State<CafeSelectorWidget> {
  bool _isDropdownVisible = false;  // Видимость выпадающего списка
  final List<String> _cafes = [
    'Кафе на Пушкинской',
    'Кафе на Арбате',
    'Кафе в Сокольниках',
    'Кафе на Тверской',
    'Кафе на Красной площади',
    'Кафе у Кремля',
    'Кафе на ВДНХ',
  ];
  
  List<String> _filteredCafes = [];  // Отфильтрованный список кофеен
  final TextEditingController _searchController = TextEditingController();  // Контроллер для строки поиска

  @override
  void initState() {
    super.initState();
    _filteredCafes = _cafes;  // По умолчанию показываем все кофейни
  }

  // Обработка поиска
  void _filterCafes(String query) {
    setState(() {
      _filteredCafes = _cafes
          .where((cafe) => cafe.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownVisible = !_isDropdownVisible;  // Переключаем видимость списка
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedCafe ?? 'Введите адрес кофейни',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  _isDropdownVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownVisible)
          Column(
            children: [
              // Поле поиска
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterCafes,
                  decoration: const InputDecoration(
                    hintText: 'Поиск кофейни...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Выпадающий список кофеен
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),  // Мутный фон для списка
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  maxHeight: 200,  // Ограничение высоты на 5 элементов
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredCafes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _filteredCafes[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          _isDropdownVisible = false;
                        });
                        widget.onCafeSelected(_filteredCafes[index]);  // Передаем выбранную кофейню
                      },
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
