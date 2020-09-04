import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
        home: HomeScreen()
    )
  );


}
