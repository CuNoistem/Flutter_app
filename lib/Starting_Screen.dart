import 'package:flutter/material.dart';
import 'package:project/Bluetooth_Screen.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'miniBot',
                    style: TextStyle(
                    color: Color(0xEBFFD01E),
                    fontWeight: FontWeight.w800,
                    fontSize: 150,
                    ),
                  )
                ),
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Bluetooth_ScreenRoute()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xEBFFD01E),
                      elevation: 3.0, 
                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(13), ),
                    ),
                    child: const Text(
                      "START",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                  )
                )
              ],
            )
          ),
        )
      )
    );
  }
}