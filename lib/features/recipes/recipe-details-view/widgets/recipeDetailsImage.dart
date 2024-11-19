import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeDetailsImage extends StatelessWidget {
  const RecipeDetailsImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      // fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, url) => const Icon(
        Icons.fastfood_rounded,
        size: 200,
      ),
      imageBuilder: (context, imageProvider) => Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(4, 6),
            ),
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.fastfood_rounded,
        size: 200,
      ),
    );
  }
}
