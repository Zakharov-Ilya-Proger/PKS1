import 'package:flutter/material.dart';
import '../api.dart'; // Импорт ApiService
import '../models/AnalysisItem.dart'; // Импорт модели AnalysisItem
import '../templates/homePageCard.dart'; // Импорт виджета HomePageCard

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
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = ApiService().getProducts();
    });
  }

  void _filterProducts(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _showAddItemDialog(BuildContext context, Analyze? item) {
    final _titleController = TextEditingController(text: item?.title ?? '');
    final _daysController = TextEditingController(text: item?.days ?? '');
    final _costController = TextEditingController(text: item?.cost.toString() ?? '');
    String _selectedType = item?.type ?? 'кровь';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Обновить или удалить анализ'),
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
                      final updatedItem = Analyze(
                        id: item?.id ?? DateTime.now().millisecondsSinceEpoch,
                        title: title,
                        cost: cost,
                        days: days,
                        type: _selectedType,
                        favorite: item?.favorite ?? false,
                      );

                      try {
                        if (item != null) {
                          await ApiService().updateProduct(updatedItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Элемент успешно обновлен!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          await ApiService().addProductToServer(updatedItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Элемент успешно добавлен!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                        _titleController.clear();
                        _daysController.clear();
                        _costController.clear();
                        Navigator.of(context).pop();
                        _loadProducts();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка обновления элемента: $e'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пожалуйста, заполните все поля'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('Обновить или добавить'),
                ),
                TextButton(
                  onPressed: () async {
                    if (item != null) {
                      try {
                        await ApiService().deleteProduct(item.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Элемент успешно удален!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context).pop();
                        _loadProducts(); // Перезапрашиваем данные с сервера
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка удаления элемента: $e'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Удалить'),
                ),
              ],
            );
          },
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
                    itemCount: filteredProducts.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == filteredProducts.length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _showAddItemDialog(context, null);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: index == filteredProducts.length - 1 ? 15 : 16),
                            child: GestureDetector(
                              onTap: () {
                                _showAddItemDialog(context, filteredProducts[index]);
                              },
                              child: HomePageCard(item: filteredProducts[index]),
                            ),
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
