import 'package:flutter/material.dart';
import '../api.dart'; // Импорт ApiService
import '../models/AnalysisItem.dart'; // Импорт модели AnalysisItem
import '../temlates/homePageCard.dart'; // Импорт виджета HomePageCard

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Analyze>> _productsFuture;
  String _selectedFilter = 'все';

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().getProducts();
  }

  void _filterProducts(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _showAddItemDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _daysController = TextEditingController();
    final _costController = TextEditingController();
    String _selectedType = 'кровь';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый анализ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                ),
              ),
              TextField(
                controller: _daysController,
                decoration: const InputDecoration(
                  labelText: 'Дни',
                ),
              ),
              TextField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Стоимость',
                ),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  }
                },
                items: <String>['кровь', 'кал', 'моча']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () async {
                final title = _titleController.text;
                final days = _daysController.text;
                final cost = int.tryParse(_costController.text) ?? 0;

                if (title.isNotEmpty && days.isNotEmpty && cost > 0) {
                  final newItem = Analyze(
                    id: DateTime.now().millisecondsSinceEpoch, // Генерируем уникальный ID
                    title: title,
                    cost: cost,
                    days: days,
                    type: _selectedType,
                    favorite: false,
                  );

                  try {
                    await ApiService().addProductToServer(newItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Элемент успешно добавлен!'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    // Очищаем поля после успешного добавления
                    _titleController.clear();
                    _daysController.clear();
                    _costController.clear();
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ошибка добавления элемента: $e'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Пожалуйста, заполните все поля'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 92, left: 27),
                child: Text(
                  "Каталог услуг",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 92, left: 27, right: 35),
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _filterProducts(newValue);
                    }
                  },
                  items: <String>['все', 'кровь', 'кал', 'моча']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Analyze>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Ошибка загрузки данных"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Каталог пуст",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  List<Analyze> products = snapshot.data!;
                  List<Analyze> filteredProducts = products.where((product) {
                    return _selectedFilter == 'все' || product.type == _selectedFilter;
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredProducts.length + 1, // Добавляем один элемент для иконки
                    itemBuilder: (BuildContext context, int index) {
                      if (index == filteredProducts.length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _showAddItemDialog(context);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: index == filteredProducts.length - 1 ? 25 : 16),
                            child: HomePageCard(item: filteredProducts[index]),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
