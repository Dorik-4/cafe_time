import 'package:cafe_time/widgets/product_card.dart';
import 'package:flutter/material.dart';
import '../services/menu.dart';
import '../widgets/cafe_selector_widget.dart';
import '../widgets/bonus_program_widget.dart';
import '../common_gradient.dart';

class MenuScreen extends StatefulWidget {
  final String? category;
  final int? productId;

  const MenuScreen({super.key, this.category, this.productId});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late List<String> _categories = [];
  String _selectedCategory = 'Все';
  String? _selectedCafe;
  final String _phoneNumber = '+7 917 999-99-99';
  final ScrollController _scrollController = ScrollController();
  late List<ProductItem> _products = [];
  List<int> cart = [];

  void addToCart(int productId) {
    setState(() {
      cart.add(productId);
    });
  }

  void removeFromCart(int productId) {
    setState(() {
      cart.remove(productId);
    });
  }

  void increaseQuantity(int productId) {
    setState(() {
      cart.add(productId);
    });
  }

  void decreaseQuantity(int productId) {
    setState(() {
      cart.remove(productId);
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.category != null) {
        setState(() {
          _selectedCategory = widget.category!;
        });
      }

      if (widget.productId != null) {
        final index = _products.indexWhere((product) => product.id == widget.productId);
        if (index != -1) {
          _scrollController.animateTo(
            index * 230.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  _asyncMethod() async {
    _categories = await fetchCategories();
    _products = await fetchMenu();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _selectedCategory == 'Все'
        ? _products
        : _products.where((product) => product.idCategory == _categories.indexOf(_selectedCategory)).toList();

    return Scaffold(
      body: Container(
        decoration: commonGradientBackground(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Выберите кафе',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    CafeSelectorWidget(
                      selectedCafe: _selectedCafe,
                      onCafeSelected: (String cafe) {
                        setState(() {
                          _selectedCafe = cafe;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    BonusProgramWidget(phoneNumber: _phoneNumber),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedCategory == _categories[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = _categories[index];
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.brown.withOpacity(0.8) : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 2)
                                    : Border.all(color: Colors.transparent),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.4),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSelected ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Товары',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                    bottom: 16.0,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    int quantity = cart.where((id) => id == product.id).length;
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Padding(padding: EdgeInsets.only(top: 5)),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                  product.photoUrl,
                                  // height: 150,
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style:
                                  const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Цена: ${product.price} руб.',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green
                                ),
                              ),

                              quantity == 0
                                ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon:
                                    const Icon(
                                        Icons.add_circle,
                                        size: 40
                                    ),
                                    onPressed: () =>
                                        increaseQuantity(product.id),
                                  ),
                                )
                                : Row(
                                    mainAxisAlignment:
                                      MainAxisAlignment.center,
                                    children: [
                                  IconButton(
                                    icon:
                                      const Icon(
                                          Icons.remove_circle,
                                          size: 40
                                      ),
                                    onPressed: () =>
                                        decreaseQuantity(product.id),
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  IconButton(
                                    icon:
                                      const Icon(
                                          Icons.add_circle,
                                          size: 40
                                      ),
                                    onPressed: () =>
                                        increaseQuantity(product.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


