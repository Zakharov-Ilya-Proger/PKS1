import 'package:flutter/material.dart';

import '../main.dart';
import '../temlates/homePageCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 92, left: 27),
            child: Text(
              "Каталог услуг",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: data.isEmpty
                ? const Align(
              alignment: Alignment.center,
              child: Text(
                "Каталог пуст",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: index == data.length - 1 ? 32: 16),
                    child: HomePageCard(item: data[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
