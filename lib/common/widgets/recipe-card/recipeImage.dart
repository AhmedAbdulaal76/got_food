import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

class RecipeImage extends StatelessWidget {
  final String imageUrl;

  const RecipeImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ThemeColors.primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.primaryColorDark.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Icon(
              Icons.fastfood_rounded,
              size: 64,
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {}, // TODO: Add to favourite
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: ThemeColors.primaryColorLight,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
