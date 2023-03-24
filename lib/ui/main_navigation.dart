import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inviders_losts/bloc/home_page_bloc.dart';
import 'package:inviders_losts/ui/home_page.dart';

abstract class MainNavigationRouteNames {
  static const homePage = '/';
  static const initialRoute = homePage;
}

class MainNavigation {
  Map<String, Widget Function(BuildContext)> routes = {
    MainNavigationRouteNames.homePage: (_) {
      return BlocProvider<HomePageBloc>(
          create: (_) => HomePageBloc(),
          child: const MyHomePage(),
        );
    },
  };
}
