import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pks3/pages/CartPage.dart';
import 'package:pks3/pages/HomePage.dart';
import 'package:pks3/pages/PlanPage.dart';
import 'package:pks3/pages/UserPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/auth_gate.dart';
import 'models/BasketItem.dart';

List<CartItem> cart = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://zdhajtovqvlvpqxiiamz.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpkaGFqdG92cXZsdnBxeGlpYW16Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQyNzAzODIsImV4cCI6MjA0OTg0NjM4Mn0.Fll7jUG86ViBraZMbSlPQhqTjv5Tp9hEMdi9-9b8kNo",
  );
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
      home: AuthGate(), // Используйте AuthGate для проверки аутентификации
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
    PlanPage(),
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Главная',
              activeIcon: Icon(
                Icons.home_filled,
                color: Color(0xFF1A6FEE),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'План',
              activeIcon: Icon(
                Icons.assignment,
                color: Color(0xFF1A6FEE),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Корзина',
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Color(0xFF1A6FEE),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xFF1A6FEE),
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
