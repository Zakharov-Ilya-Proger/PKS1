import 'package:flutter/material.dart';
import 'package:pks3/components/KvasCard.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/pages/KvasPage.dart';
import '../api_service.dart';
import '../main.dart';

class FavoritesPage extends StatefulWidget {

  const FavoritesPage({
    super.key,
  });

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<KvasItem> favoriteNotesList;

  @override
  void initState() {
    super.initState();
  }

  List<KvasItem> _takeFavorite(List<KvasItem> abba) {
    List<KvasItem> aboba = [];
    for (var item in abba) {
      if (item.lovely == true) {
        aboba.add(item);
      }
    }
    return aboba;
  }

  void _toggleFavorite(KvasItem kvas) {
    setState(() {
      kvas.lovely = !kvas.lovely;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favorite.isEmpty
          ? const Center(
        child: Text(
          "Нет Избранных квасов",
          style: TextStyle(fontSize: 20),
        ),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // Adjust as needed
        ),
        itemCount: favorite.length,
        itemBuilder: (BuildContext context, int index) {
          final kvas = favorite[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => kvasPage(
                kvasFuture: ApiService().getProduct(favorite[index].ID,
                  ),
                ),
              ));
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
                      _toggleFavorite(kvas);
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
