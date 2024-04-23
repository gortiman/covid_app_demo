import 'package:covid_tracker/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // ThemeData(
      //   primarySwatch: Colors.blue,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
      //   useMaterial3: true,
      // ),
      home: SplashScreen(),
    );
  }
}

// https://github.com/axiftaj/Flutter-Covid-19-App/tree/main/lib