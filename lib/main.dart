import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pks3/auth/auth_service.dart';
import 'package:pks3/pages/CartPage.dart';
import 'package:pks3/pages/HomePage.dart';
import 'package:pks3/pages/PlanPage.dart';
import 'package:pks3/pages/UserPage.dart';
import 'package:provider/provider.dart';
import 'auth/auth_gate.dart';
import 'models/BasketItem.dart';
import 'firebase_options.dart';

List<CartItem> cart = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: AuthGate(),
    )
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
