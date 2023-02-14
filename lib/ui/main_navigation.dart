import 'package:flutter/material.dart';
import 'package:inviders_losts/ui/home_page.dart';
import 'package:inviders_losts/ui/home_page_model.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const homePage = '/';
  static const initialRoute = homePage;
}

class MainNavigation {
  Map<String, Widget Function(BuildContext)> routes = {
    MainNavigationRouteNames.homePage: (_) =>
        ChangeNotifierProvider<HomePageModel>(
            create: (_) => HomePageModel(), child: const MyHomePage()),
  };
}
