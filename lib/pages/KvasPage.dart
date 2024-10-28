import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/api_service.dart';

class kvasPage extends StatelessWidget {
  final Future<KvasItem> kvasFuture;
  final ApiService apiService = ApiService(); // Инициализируем экземпляр ApiService

  kvasPage({super.key, required this.kvasFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Страница отдельного кваса"),
        ),
      ),
      body: FutureBuilder<KvasItem>(
        future: kvasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product found'));
          }

          final item = snapshot.data!;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 50,
                  right: 15,
                  left: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.network(item.imageUrl),
                    ),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final item = await kvasFuture;
          await apiService.deliteKvas(item.ID);
          Navigator.pop(context);
        },
        child: const Icon(Icons.accessible_forward_sharp),
      ),
    );
  }
}
