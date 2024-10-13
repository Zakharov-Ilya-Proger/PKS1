import 'package:flutter/material.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import '../components/KvasCard.dart';
import '../main.dart';
import 'KvasPage.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Корзина"),
        ),
      ),
      body: basket.isEmpty
          ? const Center(
        child: Text(
          "Корзина пуста",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      )
          : Center(
        child: ListView.builder(
          itemCount: basket.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        _deleteFromBasketConfirmation(context, index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Удалить',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => kvasPage(item: basket[index].kvas)),
                    );
                  },
                  child: Stack(
                    children: [
                      KvasCard(item: basket[index].kvas),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (basket[index].count > 0) {
                                    basket[index].count--;
                                  }
                                  if (basket[index].count == 0) {
                                    _deleteFromBasketConfirmation(context, index);
                                  }
                                });
                              },
                            ),
                            Text('${basket[index].count}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  basket[index].count++;
                                });
                              },
                            ),
                          ],
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

  void _deleteFromBasketConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить из корзины?'),
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
                  basket.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}
