import 'package:flutter/material.dart';
import 'package:inviders_losts/theme/theme.dart';
import 'package:inviders_losts/ui/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      routes: mainNavigation.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}