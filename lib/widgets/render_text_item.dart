import 'package:flutter/material.dart';

class RenderTextItem extends StatelessWidget {
  final String item;
  final Function(String item)? onClicked;
  final Color? bgcolor;
  final TextStyle? style;
  const RenderTextItem({
    super.key,
    this.bgcolor,
    required this.item,
    this.onClicked,
    this.style = const TextStyle(color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClicked != null) {
          onClicked!(item);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: bgcolor ?? Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
