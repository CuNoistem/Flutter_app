import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Starting_Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}