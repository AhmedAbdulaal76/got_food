import 'package:flutter/material.dart';

import 'features/home/home-view/widgets/homePage.dart';

Map<String, Widget Function(BuildContext)> get routes => {
      '/home': (context) => const HomePage(),
    };
