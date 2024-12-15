import 'package:flutter/material.dart';
import '../temlates/homePageCard.dart';
import '../api.dart';
import '../models/AnalysisItem.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  late Future<List<Analyze>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = ApiService().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 92, left: 27),
            child: Text(
              "Избранные услуги",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Analyze>>(
              future: _favoritesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Ошибка загрузки данных"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Избранные услуги пусты",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  List<Analyze> favorites = snapshot.data!;
                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: index == favorites.length - 1 ? 32 : 16),
                          child: HomePageCard(item: favorites[index]),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
