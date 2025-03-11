
import 'package:flutter/material.dart';
import 'home_screen.dart';

// Import the ffi package
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // This is required for desktop platforms (Windows, Linux, macOS)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
