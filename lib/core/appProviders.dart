import 'package:got_food/common/providers/bottomNavigationProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get appProviders => [
      ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
    ];
