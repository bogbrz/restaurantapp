import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:restaurantapp/app/app.dart';
import 'package:restaurantapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
