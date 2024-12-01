import 'package:flutter/cupertino.dart';
import 'package:late_blight/widgets/network.image.dart';

class KuKrishiRoundedItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Size size;
  final Radius radius;
  final void Function()? onClick;

  const KuKrishiRoundedItem(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.size = const Size(45, 45),
      this.onClick,
      this.radius = const Radius.circular(12)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: GestureDetector(
        onTap: () {
          if (onClick != null) onClick!();
        },
        child: Column(
          children: [
            LateBlightNetworkImage(
              url: imageUrl,
              size: size,
              radius: radius,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
