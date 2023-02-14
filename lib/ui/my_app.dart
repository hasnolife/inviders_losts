import 'package:flutter/material.dart';
import 'package:inviders_losts/ui/home_page.dart';
import 'package:inviders_losts/ui/home_page_model.dart';
import 'package:inviders_losts/ui/main_navigation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: mainNavigation.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}