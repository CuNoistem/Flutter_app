// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project/Bluetooth_Screen.dart';
import 'package:project/Line_Tracking_Mode.dart';
import 'package:project/Manual_Mode.dart';
import 'package:project/Obstacle_Avoiding_Mode.dart';

BluetoothCharacteristic? targetCharacteristic;
String uuid = "0000ffe0-0000-1000-8000-00805f9b34fb";
String writeUuid = "0000ffe1-0000-1000-8000-00805f9b34fb";
FlutterBlue flutterBlue = FlutterBlue.instance;

class SelectionScreenRoute extends StatelessWidget {
  const SelectionScreenRoute({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 45, 45, 45),
      home: SelectionScreen(device: device),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key, required this.device});

  final BluetoothDevice device;

  static discoverService(BluetoothDevice device) async {
    bool connectFlag = false;
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == uuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == writeUuid) {
            targetCharacteristic = characteristic;
            connectFlag = true;
          }
        }
      }
    }

    if (!connectFlag) {
      targetCharacteristic = null;
    }
  }

  static writeData(int data) async {
    if (targetCharacteristic == null) {
      return;
    }

    await targetCharacteristic!.write([data], withoutResponse: true);
  }

  @override
  Widget build(BuildContext context) {
    discoverService(device);
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
            } else if (targetCharacteristic == null) {
              return Container(
                color: const Color.fromARGB(255, 45, 45, 45),
                child: const AlertServiceWidget(),
              );
            } else {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Manual Mode
                  Container(
                    width: 290,
                    height: 370,
                    color: Colors.black,
                    child: ElevatedButton(
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Manual_ModeRoute(device: device)));

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Center(
                          child: Text(
                            "MANUAL DRIVE MODE",
                            style: TextStyle(
                              color: Color(0xEBFFD01E),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                  ),
                  //Obstacle Avoiding Mode
                  Container(
                    width: 290,
                    height: 370,
                    color: const Color(0xEBFFD01E),
                    child: ElevatedButton(
                        onPressed: () {
                          if (targetCharacteristic != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Obstacle_AvoidingRoute(device: device)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertWidget());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xEBFFD01E),
                          elevation: 0,
                        ),
                        child: const Center(
                          child: Text(
                            "OBSTACLE MODE",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                  ),
                  //Line Tracking Mode
                  Container(
                    width: 290,
                    height: 370,
                    color: Colors.black,
                    child: ElevatedButton(
                        onPressed: () {
                          if (targetCharacteristic != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Line_TrackingRoute(device: device)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertWidget());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Center(
                          child: Text(
                            "LINE TRACKING MODE",
                            style: TextStyle(
                              color: Color(0xEBFFD01E),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        )),
                  ),
                ],
              );
            }
          },
        ));
  }
}

class AlertServiceWidget extends StatelessWidget{
  const AlertServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    targetCharacteristic = null;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      backgroundColor: const Color.fromARGB(255, 80, 80, 80),
      title: const Text(
        "Bluetooth Service Missing",
        style: TextStyle(
          color: Color(0xEBFFD01E),
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        "Bluetooth services are missing. Try again.",
        style: TextStyle(
          color: Color(0xEBFFD01E),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Bluetooth_ScreenRoute())),
          child: const Text(
            "OK",
            style: TextStyle(
                color: Color(0xEBFFD01E), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    targetCharacteristic = null;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      backgroundColor: const Color.fromARGB(255, 80, 80, 80),
      title: const Text(
        "Bluetooth Device Disconnected",
        style: TextStyle(
          color: Color(0xEBFFD01E),
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        "Bluetooth device is disconnected. Try again.",
        style: TextStyle(
          color: Color(0xEBFFD01E),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Bluetooth_ScreenRoute())),
          child: const Text(
            "OK",
            style: TextStyle(
                color: Color(0xEBFFD01E), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
