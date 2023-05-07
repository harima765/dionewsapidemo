import 'package:dionewsapidemo/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>NewsProvider(),
      child:  const MaterialApp(
        home: NewsScreen(),
      ),
    );
  }
}

