// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:project/Selection_Screen.dart';

int count = 0;

class Manual_ModeRoute extends StatelessWidget {
  const Manual_ModeRoute({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manual_Mode(device: device),
    );
  }
}

class Manual_Mode extends StatefulWidget {
  const Manual_Mode({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ManualModeState createState() => _ManualModeState(device);
}

const step = 10.0;
bool led_flag = true;

class _ManualModeState extends State<Manual_Mode> {
  double _x = 100;
  double _y = 100;
  int speed = 0;
  int direction = 0;
  final JoystickMode _joystickMode = JoystickMode.all;

  _ManualModeState(this.device);

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 45, 45, 45),
                  body: SafeArea(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 45, 45, 45),
                            ),
                            Center(
                              child: Joystick(
                                mode: _joystickMode,
                                listener: (details) {
                                  setState(() async {
                                    _x = _x + step * details.x;
                                    _y = _y + step * details.y;

                                    if (((details.x).abs() <
                                            (details.y).abs()) &&
                                        details.y < 0) {
                                      direction = 1;
                                    } else if (((details.x).abs() <
                                            (details.y).abs()) &&
                                        details.y > 0) {
                                      direction = 3;
                                    } else if (((details.x).abs() >
                                            (details.y).abs()) &&
                                        details.x > 0) {
                                      direction = 2;
                                    } else if (((details.x).abs() >
                                            (details.y).abs()) &&
                                        details.x < 0) {
                                      direction = 4;
                                    } else {
                                      direction = 0;
                                    }

                                    SelectionScreen.writeData(direction);
                                    SelectionScreen.writeData(speed);

                                    // Starts from 75 to 255 PWM value
                                    speed = (75 +
                                            (sqrt(details.x * details.x) +
                                                    (details.y * details.y)) *
                                                240)
                                        .round();
                                    if (speed > 255) {
                                      speed = 255;
                                    }
                                  });
                                },
                              ),
                            ),
                            Text(
                                'Speed: $speed\nDirection: $direction\nDevice State: ${snapshot.data}'),
                          ],
                        ),
                        Container(
                          color: const Color.fromARGB(255, 45, 45, 45),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Back Button
                                Container(
                                  width: 350,
                                  height: 45,
                                  margin: const EdgeInsets.all(8),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        led_flag = true;
                                        SelectionScreen.writeData(9);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectionScreenRoute(
                                                        device: device)));
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      backgroundColor: Colors.black,
                                      side: const BorderSide(
                                          color: Color(0xEBFFD01E), width: 2),
                                    ),
                                    child: const Text(
                                      "BACK",
                                      style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        color: Color(0xEBFFD01E),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: const Text(
                                    "LED MODES",
                                    style: TextStyle(
                                      color: Color(0xEBFFD01E),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //Blinking
                                    Container(
                                      width: 170,
                                      height: 45,
                                      margin: const EdgeInsets.all(7),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            SelectionScreen.writeData(5);
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          backgroundColor: Colors.black,
                                          side: const BorderSide(
                                              color: Color(0xEBFFD01E),
                                              width: 2),
                                        ),
                                        child: const Text(
                                          "BLINKING",
                                          style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            color: Color(0xEBFFD01E),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Breathing
                                    Container(
                                      width: 170,
                                      height: 45,
                                      margin: const EdgeInsets.all(7),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            SelectionScreen.writeData(6);
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          backgroundColor: Colors.black,
                                          side: const BorderSide(
                                              color: Color(0xEBFFD01E),
                                              width: 2),
                                        ),
                                        child: const Text(
                                          "BREATHING",
                                          style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            color: Color(0xEBFFD01E),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 350,
                                  height: 45,
                                  margin: const EdgeInsets.all(8),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (led_flag) {
                                          SelectionScreen.writeData(7);
                                        } else {
                                          SelectionScreen.writeData(8);
                                        }
                                        led_flag = !led_flag;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      backgroundColor: Colors.black,
                                      side: const BorderSide(
                                          color: Color(0xEBFFD01E), width: 2),
                                    ),
                                    child: led_flag
                                        ? const Text(
                                            "START LED",
                                            style: TextStyle(
                                              color: Color(0xEBFFD01E),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1,
                                            ),
                                          )
                                        : const Text(
                                            "STOP LED",
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
                      ],
                    ),
                  ));
            }
          }),
    );
  }
}
