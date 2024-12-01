import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'boardingAppBar.dart';
import 'slide.dart';

class BoardingPage extends StatefulWidget {
  const BoardingPage({super.key});

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  // initializing the current slide index
  int current = 0;

  @override
  Widget build(BuildContext context) {
    // Localized titles and subtitles
    final List<String> titles = [
      'Chocolate cake',
      'Grilled chicken',
      'rotten bird',
    ];

    final List<String> subtitles = [
      'delicous chocolate cake',
      'grilled chicken with some spices',
      'rotten bird with some spices',
    ];

    final List<String> images = [
      "assets/images/chocolate-cake.jpg",
      "assets/images/chicken.jpeg",
      "assets/images/rotten-bird.jpg",
    ];

    // Generating the slides from the data above
    final List<Widget> slides = List.generate(
      titles.length,
      (index) => Slide(
        title: titles[index],
        subtitle: subtitles[index],
        image: images[index],
      ),
    );

    return Scaffold(
      appBar: BoardingAppBar(current: current, slides: slides),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CarouselSlider to display the slides
              CarouselSlider(
                items: slides,
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                ),
              ),
              // Row of indicators for the current slide
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slides.map(
                  (slide) {
                    int index = slides.indexOf(slide);
                    return Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.blueGrey,
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 32),
              // change button functionality & label based on index
              ElevatedButton(
                onPressed: () {
                  current == slides.length - 1
                      ? Navigator.pushNamed(context, "/home")
                      : Navigator.pushNamed(context, "/signup");
                },
                child: Text(
                  current == slides.length - 1
                      ? 'Get Started with the best recipes'
                      : 'Create an account',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text(
                  'login',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
