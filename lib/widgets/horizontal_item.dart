import 'package:flutter/material.dart';
import 'package:late_blight/widgets/network.image.dart';

class KuKrishiHorizontalItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Size size;
  final Radius radius;
  final void Function()? onClick;

  const KuKrishiHorizontalItem(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.size = const Size(45, 45),
      this.onClick,
      this.radius = const Radius.circular(12)});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () {
          if (onClick != null) onClick!();
        },
        child: SizedBox(
          width: Size.infinite.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LateBlightNetworkImage(
                  url: imageUrl,
                  size: size,
                  radius: radius,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
