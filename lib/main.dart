import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pks3/pages/CartPage.dart';
import 'package:pks3/pages/HomePage.dart';
import 'package:pks3/pages/UserPage.dart';
import 'models/AnalysisItem.dart';
import 'models/BasketItem.dart';


List<CartItem> cart = [];
List<Analyze> data = [
  Analyze(title: "ПЦР-тест на определение РНК коронавируса стандартный", cost: 1800, days: "2 дня", id: 1),
  Analyze(title: "Клинический анализ крови с лейкоцитарной формулировкой", cost: 690, days: "1 день", id: 2),
  Analyze(title: "Биохимический анализ крови, базовый",cost:  2440, days: "1 день", id: 3),
  Analyze(title: "Анализ на дебила", cost: 1500, days: "1 день", id: 4),
  Analyze(title: "Исследование плазмы крови", cost: 2500, days: "5 дней", id: 5),
  Analyze(title: "Исследование на антитиела", cost: 3000, days: "4 дня", id: 6)
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
        textTheme: GoogleFonts.montserratTextTheme(),
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
    HomePage(),
    CartPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 88,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/media/HomeIcon.svg"),
              label: 'Главная',
              activeIcon: SvgPicture.asset(
                "lib/media/HomeIcon.svg",
                color: const Color(0xFF1A6FEE),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/media/CartIcon.svg"),
              label: 'Карзина',
              activeIcon: SvgPicture.asset(
                "lib/media/CartIcon.svg",
                color: const Color(0xFF1A6FEE),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("lib/media/UserIcon.svg"),
              label: 'Профиль',
              activeIcon: SvgPicture.asset(
                "lib/media/UserIcon.svg",
                color: const Color(0xFF1A6FEE),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFF1A6FEE), // Customize as needed
          onTap: _onItemTapped,

        ),
      ),
    );
  }
}
