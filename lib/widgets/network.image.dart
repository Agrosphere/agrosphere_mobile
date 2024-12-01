import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LateBlightNetworkImage extends StatelessWidget {
  final String url;
  final Radius radius;
  final BoxFit boxFit;
  final Size size;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Border? border;
  const LateBlightNetworkImage({
    super.key,
    required this.url,
    this.radius = Radius.zero,
    this.boxFit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.size = const Size(48, 48),
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.all(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      placeholder: (context, url) => ClipRRect(
        borderRadius: BorderRadius.all(radius),
        child: placeholder ??
            Image.asset(
              "assets/logo.png",
              height: size.height,
              width: size.width,
              fit: boxFit,
              filterQuality: FilterQuality.medium,
            ),
      ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: BorderRadius.all(radius),
        child: errorWidget ??
            Image.asset(
              "assets/logo.png",
              height: size.height,
              width: size.width,
              fit: boxFit,
              filterQuality: FilterQuality.medium,
            ),
      ),
    );
  }
}
