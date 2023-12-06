import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 370,
                height: 45,
                margin: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Color(0xEBFFD01E), width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13),),
                  ),
                  child: const Text(
                    "BACK",
                    style: TextStyle(
                      color: Color(0xEBFFD01E),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text(
                  "OBSTACLE AVOIDING MODE",
                  style: TextStyle(
                    color: Color(0xEBFFD01E),
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1
                  ),
                ),
              ),
              Container(
                width: 370,
                height: 50,
                margin: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xEBFFD01E), width: 2),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13),),
                  ),
                  child: const Text(
                    "START AVOIDING",
                    style: TextStyle(
                      color: Color(0xEBFFD01E),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}