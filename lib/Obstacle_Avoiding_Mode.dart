// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project/Selection_Screen.dart';

class Obstacle_AvoidingRoute extends StatelessWidget {
  const Obstacle_AvoidingRoute({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Obstacle_Avoiding(device: device),
    );
  }
}

bool obstacle_flag = true;

class Obstacle_Avoiding extends StatefulWidget {
  const Obstacle_Avoiding({super.key, required this.device});

  final BluetoothDevice device;

  @override
  // ignore: no_logic_in_create_state
  State<Obstacle_Avoiding> createState() => _Obstacle_AvoidingState(device);
}

class _Obstacle_AvoidingState extends State<Obstacle_Avoiding> {
  _Obstacle_AvoidingState(this.device);
  final BluetoothDevice device;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        body: StreamBuilder<BluetoothDeviceState>(
          stream: device.state,
          initialData: BluetoothDeviceState.connected,
          builder: (c, snapshot) {
            if (snapshot.data == BluetoothDeviceState.disconnected) {
              return Container(
                color: const Color.fromARGB(255, 45, 45, 45),
                child: const AlertWidget(),
              );
            } else {
              return Center(
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
                        onPressed: () {
                          obstacle_flag = true;
                          SelectionScreen.writeData(0);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SelectionScreenRoute(device: widget.device)));
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: const BorderSide(
                              color: Color(0xEBFFD01E), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Text(
                          "BACK",
                          style: TextStyle(
                              color: Color(0xEBFFD01E),
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1),
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
                            letterSpacing: 1),
                      ),
                    ),
                    Container(
                      width: 370,
                      height: 50,
                      margin: const EdgeInsets.all(10),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (obstacle_flag) {
                              SelectionScreen.writeData(10);
                            } else {
                              SelectionScreen.writeData(0);
                            }
                            obstacle_flag = !obstacle_flag;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xEBFFD01E), width: 2),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: obstacle_flag
                            ? const Text(
                                "START AVOIDING",
                                style: TextStyle(
                                  color: Color(0xEBFFD01E),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              )
                            : const Text(
                                "STOP AVOIDING",
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
              );
            }
          },
        ));
  }
}
