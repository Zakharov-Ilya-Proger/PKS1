import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';
import 'package:pks3/api_service.dart';

class kvasPage extends StatefulWidget {
  final Future<KvasItem> kvasFuture;

  kvasPage({super.key, required this.kvasFuture});

  @override
  State<kvasPage> createState() => _kvasPageState();
}

class _kvasPageState extends State<kvasPage> {
  final ApiService apiService = ApiService();
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> updateKvas(KvasItem item) async {
    try {
      final updatedItem = KvasItem(
        ID: item.ID,
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: imageUrlController.text,
      );
      await apiService.updateKvas(updatedItem);
      Navigator.pop(context);
    } catch (e) {
      print('Error updating kvas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Страница отдельного кваса"),
        ),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: toggleEdit,
          ),
        ],
      ),
      body: FutureBuilder<KvasItem>(
        future: widget.kvasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product found'));
          }

          final item = snapshot.data!;

          if (isEditing) {
            nameController.text = item.name;
            descriptionController.text = item.description;
            imageUrlController.text = item.imageUrl;
          }

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
                    if (isEditing)
                      Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Название',
                            ),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Описание',
                            ),
                          ),
                          TextField(
                            controller: imageUrlController,
                            decoration: const InputDecoration(
                              labelText: 'URL изображения',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => updateKvas(item),
                            child: const Text('Сохранить'),
                          ),
                        ],
                      )
                    else
                      Column(
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final item = await widget.kvasFuture;
          await apiService.deliteKvas(item.ID);
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
