import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothListWidget extends StatefulWidget {
  const BluetoothListWidget({Key? key}) : super(key: key);

  @override
  _BluetoothListWidgetState createState() => _BluetoothListWidgetState();
}

class _BluetoothListWidgetState extends State<BluetoothListWidget> {
  List<BluetoothDevice> _devices = [];
  late StreamSubscription<List<ScanResult>> _scanSubscription;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _startScanning();
  }
  Future<void> _checkPermissions() async {
    // Check if Bluetooth scanning permission is granted by the flutter_blue_plus plugin
    if (await Permission.bluetoothScan.isGranted) {
      // Permission granted, proceed with scanning
      _startScanning();
    } else {
      // Request Bluetooth scanning permission
      var status = await Permission.bluetoothScan.request();

      if (status.isGranted) {
        // Permission granted, proceed with scanning
        _startScanning();
      } else {
        // Permission denied, handle accordingly
        print('Bluetooth scanning permission denied');
      }
    }
  }


  void _startScanning() {
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _devices = results.map((result) => result.device).toList();
      });
    });

    FlutterBluePlus.startScan();
  }

  @override
  void dispose() {
    _scanSubscription.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      // Save the connected device information
      await _saveConnectedDevice(device.id.toString());
      // You can also perform other actions after successful connection
    } catch (e) {
      print('Failed to connect to the device: $e');
    }
  }

  Future<void> _saveConnectedDevice(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('connected_device', deviceId);
  }

  Future<BluetoothDevice?> _loadConnectedDevice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('connected_device');
    if (deviceId != null) {
      return FlutterBluePlus.connectedDevices
          .firstWhere((device) => device.id.toString() == deviceId, );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Device List'),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
            subtitle: Text(device.id.toString()),
            onTap: () {
              _connectToDevice(device);
            },
          );
        },
      ),
    );
  }
}
