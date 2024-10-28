import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/pages/KvasPage.dart';
import '../api_service.dart';
import '../components/KvasCard.dart';
import '../main.dart';
import '../models/BasketItem.dart';
import 'AddKvasPage.dart';

class Homepage extends StatefulWidget {
  List<KvasItem> kvases;

  Homepage({
    super.key,
    required this.kvases,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _apiService.getProducts();
      setState(() {
        widget.kvases = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddKvasPage(kvases: widget.kvases, onNoteAdded: (KvasItem newItem) {
        setState(() {
          widget.kvases.add(newItem);
        });
        Navigator.pop(context);
      })),
    );
  }

  void _deleteNoteConfirmation(BuildContext context, int index) {
    if(widget.kvases[index].lovely){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Удалить из избранного?'),
            content: const Text('Вы уверены, что хотите удалить этот квас?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.kvases[index].lovely = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Удалить'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        widget.kvases[index].lovely = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Страница всех квасов"),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Adjust as needed
        ),
        itemCount: widget.kvases.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => kvasPage(kvasFuture: _apiService.getProduct(widget.kvases[index].ID))),
                ).then((_) => _fetchProducts()); // Перезапрашиваем данные после возврата
              },
              onLongPress: () {
                _deleteNoteConfirmation(context, index);
              },
              child: Stack(
                children: [
                  KvasCard(item: widget.kvases[index]),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: basket.any((basketItem) => basketItem.kvas.ID == widget.kvases[index].ID)
                        ? const Icon(Icons.check)
                        : IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Добавление элемента в корзину
                        setState(() {
                          basket.add(BasketItem(widget.kvases[index], 1));
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: widget.kvases[index].lovely ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.kvases[index].lovely = !widget.kvases[index].lovely;
                          widget.kvases[index].lovely
                              ? favorite.add(widget.kvases[index])
                              : favorite.removeWhere((kvasek) => kvasek.ID == widget.kvases[index].ID);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: const Icon(Icons.add),
        tooltip: 'Добавь квас',
      ),
    );
  }
}
