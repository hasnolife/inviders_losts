import 'package:flutter/material.dart';
import 'package:inviders_losts/ui/home_page.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:inviders_losts/ui/home_page_model.dart';
import 'package:provider/provider.dart';


void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<HomePageModel>(
        create: (context) => HomePageModel(),
          child: const MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
