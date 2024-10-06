import 'package:flutter/material.dart';
import 'package:pks3/pages/FavoritesPage.dart';
import 'package:pks3/pages/ProfilePage.dart';
import 'models/KvasItem.dart';
import 'pages/HomePage.dart';

List<KvasItem> dada = [
  KvasItem(
      "Классический квас",
      "Классический квас — это традиционный напиток, изготовленный из ржаного или ячменного солода, воды, дрожжей и сахара. Он имеет характерный сладковатый вкус с легкой кислинкой и приятным ароматом. Классический квас часто подают охлажденным и является отличным освежающим напитком в жаркую погоду.",
      "https://i.pinimg.com/564x/ed/ee/c6/edeec6c7a5908d21b225c2ad20978572.jpg",
      false
  ),
  KvasItem(
      "Яблочный квас",
      "Яблочный квас — это уникальный напиток, который сочетает в себе вкус яблок и традиционного кваса. Он изготавливается из яблочного сока, ржаного солода, воды и дрожжей. Яблочный квас имеет сладкий и освежающий вкус с легкой кислинкой, что делает его отличным выбором для тех, кто любит фруктовые напитки.",
      "https://leader-dostavka.kz/upload/iblock/0b5/pt6ysqojy8qe8loch3zcn65mz74t31s1.jpg",
      false
  ),
  KvasItem(
      "Хлебный квас",
      "Хлебный квас — это напиток, изготовленный из ржаного хлеба, воды, дрожжей и сахара. Он имеет насыщенный вкус и аромат, напоминающий свежеиспеченный хлеб. Хлебный квас обладает легкой кислинкой и сладковатым послевкусием. Этот напиток часто подают охлажденным и является отличным освежающим напитком в жаркую погоду.",
      "https://frankfurt.apollo.olxcdn.com/v1/files/zmobjyi4ujj62-KZ/image",
      false
  ),
  KvasItem(
      "Медовый квас",
      "Медовый квас — это сладкий и ароматный напиток, изготовленный из меда, ржаного солода, воды и дрожжей. Он имеет насыщенный вкус меда с легкой кислинкой. Медовый квас часто подают охлажденным и является отличным освежающим напитком, который также обладает полезными свойствами меда.",
      "https://leader-dostavka.kz/upload/iblock/0b5/pt6ysqojy8qe8loch3zcn65mz74t31s1.jpg",
      false
  ),
  KvasItem(
      "Имбирный квас",
      "Имбирный квас — это пряный и освежающий напиток, изготовленный из имбиря, ржаного солода, воды, дрожжей и сахара. Он имеет характерный вкус имбиря с легкой кислинкой и приятным ароматом. Имбирный квас часто подают охлажденным и является отличным выбором для тех, кто любит пряные напитки.Эти описания могут быть использованы для создания карточек квасов в вашем приложении или на веб-сайте.",
      "https://pic.rutubelist.ru/video/ee/54/ee541f51b2ec48069338d524b0aec792.png",
      false
  ),
];

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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Homepage(),
    FavoritesPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // Customize as needed
        onTap: _onItemTapped,
      ),
    );
  }
}
