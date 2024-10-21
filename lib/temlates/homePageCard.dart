import 'package:flutter/material.dart';
import 'package:pks3/models/BasketItem.dart';

import '../main.dart';
import '../models/AnalysisItem.dart';

class HomePageCard extends StatefulWidget {
  final AnalysisItem item;

  const HomePageCard({super.key, required this.item});

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.81, // 81% от ширины экрана
      height: 136,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.days,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF939396)
                      ),
                    ),
                    Text(
                      '${widget.item.cost.toString()}₽',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!widget.item.isAdd) {
                        widget.item.isAdd = true;
                        cart.add(CartItem(widget.item));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: widget.item.isAdd
                        ? Colors.white12
                        : const Color(0xFF1A6FEE),
                    minimumSize: const Size(96, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: widget.item.isAdd
                      ? const Icon(Icons.done, color: Colors.black,)
                      : const Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
