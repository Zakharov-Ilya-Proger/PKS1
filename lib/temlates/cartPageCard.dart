import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pks3/main.dart';
import 'package:pks3/models/BasketItem.dart';

class CartPageCard extends StatefulWidget {
  final CartItem item;
  final Function(CartItem) onRemove;

  const CartPageCard({super.key, required this.item, required this.onRemove});

  @override
  State<CartPageCard> createState() => _CartPageCardState();
}

class _CartPageCardState extends State<CartPageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.81,
      height: 136,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${widget.item.item.cost.toString()}₽',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${widget.item.count} пац.',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 97,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, // Adjust this as needed
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(), // Empty constraints
                                onPressed: () {
                                  setState(() {
                                    if (widget.item.count > 0) {
                                      widget.item.count--;
                                      if (widget.item.count == 0) {
                                        widget.onRemove(widget.item);
                                      }
                                    }
                                  });
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5), // Adjust horizontal padding
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  width: 1,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(), // Empty constraints
                                onPressed: () {
                                  setState(() {
                                    widget.item.count++;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                widget.onRemove(widget.item);
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
