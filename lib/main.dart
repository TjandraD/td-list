import 'package:flutter/material.dart';
import 'package:td_list/pages/add_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TD List',
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        AddPage.id: (context) => AddPage(),
      },
    );
  }
}
