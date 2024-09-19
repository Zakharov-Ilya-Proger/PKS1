import 'package:flutter/material.dart';
import 'package:pks3/models/KvasItem.dart';

class kvasPage extends StatelessWidget {
  final KvasItem item;
  const kvasPage({super.key, required this.item, });

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
      body: SingleChildScrollView(
        child: Center(
        child: Padding(padding: const EdgeInsets.only(
              top: 50,
              bottom: 50,
              right: 15,
              left: 15),
          child: Column(
            children: [
              Text(item.name,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(item.imageUrl,),
              ),
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}
