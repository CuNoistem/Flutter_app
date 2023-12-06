// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project/Selection_Screen.dart';

class Line_TrackingRoute extends StatelessWidget {
  const Line_TrackingRoute({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Line_Tracking(device: device),
    );
  }
}

bool line_flag = true;

class Line_Tracking extends StatefulWidget {
  const Line_Tracking({super.key, required this.device});

  final BluetoothDevice device;

  @override
  // ignore: no_logic_in_create_state
  State<Line_Tracking> createState() => _Line_TrackingState(device);
}

class _Line_TrackingState extends State<Line_Tracking> {
  _Line_TrackingState(this.device);
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
                          SelectionScreen.writeData(0);
                          line_flag = true;
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
                        "LINE TRACKING MODE",
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
                            if (line_flag) {
                              SelectionScreen.writeData(11);
                            } else {
                              SelectionScreen.writeData(0);
                            }
                            line_flag = !line_flag;
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
                        child: line_flag
                            ? const Text(
                                "START TRACKING",
                                style: TextStyle(
                                  color: Color(0xEBFFD01E),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              )
                            : const Text(
                                "STOP TRACKING",
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
