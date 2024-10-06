import 'package:flutter/material.dart';
import 'package:pks3/components/KvasCard.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/pages/KvasPage.dart';
import '../main.dart';

List<KvasItem> _takeFavorite(List<KvasItem> abba){
  List<KvasItem> aboba = [];
  for (var item in abba) {
    if (item.lovely == true){
      aboba.add(item);
    }
  }
  return aboba;
}

class FavoritesPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final favoriteNotesList = _takeFavorite(dada).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // Adjust as needed
        ),
        itemCount: favoriteNotesList.length,
        itemBuilder: (BuildContext context, int index) {
          final kvas = favoriteNotesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => kvasPage(
                    item: kvas,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                KvasCard(
                  item: kvas,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kvasPage(item: kvas)),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}