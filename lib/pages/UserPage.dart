import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../models/CatrHistoryItem.dart';
import 'CartHistoryPage.dart';
import 'ChatPage.dart';
import 'LoginPage.dart';
import '../api.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  void _signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 92),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Профиль",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FutureBuilder<String?>(
                    future: Future.value(authService.getCurrentUserEmail()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text("Ошибка загрузки email");
                      } else {
                        final email = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            email ?? "Email не найден",
                            style: const TextStyle(
                              color: Color(0xFF898A8D),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 75,),
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 335,
                          height: 64,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart, color: Color(0xFF1A6FEE),),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Мои заказы",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1A6FEE),),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 335,
                          height: 64,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.chat, color: Color(0xFF1A6FEE),),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Чат техподдержки",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1A6FEE),),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ChatPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 50),
                      child: GestureDetector(
                        onTap: _signOut,
                        child: const Text(
                          "Выход",
                          style: TextStyle(
                            color: Color(0xFFFD3535),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
