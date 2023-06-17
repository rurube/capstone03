import 'dart:convert';
import 'package:capstone_design_project/connect.dart';
import 'package:capstone_design_project/device_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class BleProvider extends ChangeNotifier{
  var ds = DeviceScreenState();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  late final BluetoothDevice device = ds.widget.device;
  List<BluetoothService> bluetoothService = [];

  Future<void> sendMessage(service, msg) async {
    var characteristics = service.characteristics;
    for(BluetoothCharacteristic c in characteristics) {
      await c.write(utf8.encode(msg));
    }
  }

  Future<void> setService() async {
    List<BluetoothService> bleServices = await device.discoverServices();
    bluetoothService = bleServices;
    notifyListeners();
  }

}