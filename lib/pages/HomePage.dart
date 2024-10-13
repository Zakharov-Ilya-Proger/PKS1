import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/pages/KvasPage.dart';
import '../components/KvasCard.dart';
import '../main.dart';
import '../models/BasketItem.dart';
import 'AddKvasPage.dart';


class Homepage extends StatefulWidget {
  const Homepage({
    super.key
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
  }

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddKvasPage(onNoteAdded: (KvasItem newItem) {
        setState(() {
          dada.add(newItem);
        });
        Navigator.pop(context);
      })),
    );
  }


  void _deleteNoteConfirmation(BuildContext context, int index) {
    if(dada[index].lovely){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          AlertDialog(
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
                  dada[index].lovely = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
    }else{
      setState(() {
        dada[index].lovely = true;
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
      body: dada.isEmpty
          ? const Center(
        child: Text(
          "Пупупу, а кваса-то нет",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      )
          : Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjust as needed
          ),
          itemCount: dada.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => kvasPage(item: dada[index])),
                  );
                },
                onLongPress: () {
                  _deleteNoteConfirmation(context, index);
                },
                child: Stack(
                  children: [
                    KvasCard(item: dada[index]),
                    Positioned(
                      bottom: 8,
                        left: 8,
                      child: basket.any((basketItem) => basketItem.kvas.name == dada[index].name)
                          ? Icon(Icons.check)
                          : IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Добавление элемента в корзину
                          setState(() {
                            basket.add(BasketItem(dada[index], 1));
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
                          color: dada[index].lovely ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          _deleteNoteConfirmation(context, index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: const Icon(Icons.add),
        tooltip: 'Добавь квас',
      ),
    );
  }
}
