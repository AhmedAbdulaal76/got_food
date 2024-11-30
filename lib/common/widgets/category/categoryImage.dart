import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String imageUrl;

  const CategoryImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 100,
      width: 128,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              // color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(4, 6),
            ),
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const Icon(
        Icons.fastfood_rounded,
        size: 64,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.fastfood_rounded,
        size: 64,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
