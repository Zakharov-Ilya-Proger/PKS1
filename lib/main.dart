import 'package:flutter/material.dart';
import 'package:pks3/models/BasketItem.dart';
import 'package:pks3/pages/FavoritesPage.dart';
import 'package:pks3/pages/KvasBag.dart';
import 'package:pks3/pages/ProfilePage.dart';
import 'api_service.dart';
import 'models/KvasItem.dart';
import 'pages/HomePage.dart';

List<BasketItem> basket = [];
List<KvasItem> favorite = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Future<List<KvasItem>> _kvases;

  @override
  void initState() {
    super.initState();
    _kvases = ApiService().getProducts();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<KvasItem>>(
      future: _kvases,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return SingleChildScrollView(child: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(body: Center(child: Text('No products found', style:
          TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
          )
          ));
        }

        final kvases = snapshot.data!;

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              Homepage(kvases: kvases),
              FavoritesPage(),
              BasketPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Избранное',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Корзина"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Профиль',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.black, // Customize as needed
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
