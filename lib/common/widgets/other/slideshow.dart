import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularPageView extends StatefulWidget {
  @override
  final List<String> imageUrls;
  final double size;
  const CircularPageView({super.key, required this.imageUrls, this.size = 400});

  @override
  _CircularPageViewState createState() => _CircularPageViewState();
}

class _CircularPageViewState extends State<CircularPageView> {
  late PageController _pageController;
  late List<String> _loopedImageUrls;
  late double _size;

  @override
  void initState() {
    super.initState();
    _loopedImageUrls = [
      widget.imageUrls.last,
      ...widget.imageUrls,
      widget.imageUrls.first
    ];
    _pageController = PageController(initialPage: 1);
    _size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          if (index == 0) {
            _pageController.jumpToPage(_loopedImageUrls.length - 2);
          } else if (index == _loopedImageUrls.length - 1) {
            _pageController.jumpToPage(1);
          }
        },
        itemCount: _loopedImageUrls.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
              imageUrl: _loopedImageUrls[index],
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              placeholder: (context, url) => Icon(
                    Icons.fastfood_rounded,
                    size: 264,
                    color: Theme.of(context).colorScheme.surface,
                  ),
              errorWidget: (context, url, error) => Icon(
                    Icons.fastfood_rounded,
                    size: 264,
                    color: Theme.of(context).colorScheme.surface,
                  ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
