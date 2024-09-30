import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';

class AddKvasPage extends StatefulWidget {
  final Function(KvasItem) onNoteAdded;
  const AddKvasPage({super.key, required this.onNoteAdded});

  @override
  State<AddKvasPage> createState() => _AddKvasPageState();
}

class _AddKvasPageState extends State<AddKvasPage> {
  final TextEditingController Kvas_Controller_name = TextEditingController();
  final TextEditingController Kvas_Controller_describe = TextEditingController();
  final TextEditingController Kvas_Controller_image = TextEditingController();

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
              onPressed: () {
                final String title = Kvas_Controller_name.text;
                final String text = Kvas_Controller_describe.text;
                final String imageUrl = Kvas_Controller_image.text;

                if (title.isNotEmpty &&
                    text.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  final KvasItem newNote = KvasItem(title, text, imageUrl);
                  widget.onNoteAdded(newNote);
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
