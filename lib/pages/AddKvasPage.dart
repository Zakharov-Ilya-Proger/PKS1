import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import '../api_service.dart'; // Импортируйте ваш ApiService

class AddKvasPage extends StatefulWidget {
  final Function(KvasItem) onNoteAdded;
  final List<KvasItem> kvases;
  const AddKvasPage({
    super.key,
    required this.onNoteAdded,
    required this.kvases
  });

  @override
  State<AddKvasPage> createState() => _AddKvasPageState();
}

class _AddKvasPageState extends State<AddKvasPage> {
  final TextEditingController Kvas_Controller_name = TextEditingController();
  final TextEditingController Kvas_Controller_describe = TextEditingController();
  final TextEditingController Kvas_Controller_image = TextEditingController();
  final ApiService _apiService = ApiService(); // Создайте экземпляр ApiService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Добавление кваса"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: Kvas_Controller_name,
              decoration: const InputDecoration(
                labelText: 'Введи имя кваса',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Kvas_Controller_image,
              decoration: const InputDecoration(
                labelText: 'Введи ссылку на фото кваса',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Kvas_Controller_describe,
              decoration: const InputDecoration(
                labelText: 'Введи описание кваса',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String title = Kvas_Controller_name.text;
                final String text = Kvas_Controller_describe.text;
                final String imageUrl = Kvas_Controller_image.text;

                if (title.isNotEmpty &&
                    text.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  final KvasItem newProduct = KvasItem(
                    ID: widget.kvases.isEmpty ? 1 : widget.kvases.last.ID + 1,
                    name: title,
                    description: text,
                    imageUrl: imageUrl,
                  );
                  await _apiService.addProductToServer(newProduct);
                  widget.onNoteAdded(newProduct);
                }
              },
              child: const Text('Добавить товар'),
            ),
          ],
        ),
      ),
    );
  }
}
