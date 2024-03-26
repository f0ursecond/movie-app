// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BlueThermalScreen extends StatefulWidget {
  const BlueThermalScreen({super.key});

  @override
  _BlueThermalScreenState createState() => _BlueThermalScreenState();
}

class _BlueThermalScreenState extends State<BlueThermalScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  List<Product> menu = [
    Product(name: 'Nasi Goreng', price: 15000, qty: 2),
    Product(name: 'Nasi Rames', price: 5000, qty: 1),
    Product(name: 'Es Teh', price: 2000, qty: 3),
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bluetooth.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Blue Thermal Printer'),
        ),
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (BluetoothDevice? value) => setState(() => _device = value),
                        hint: Text("Pilih Perangkatmu"),
                        value: _device,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        initPlatformState();
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () async {
                        if (_device != null) {
                          if ((await bluetooth.isConnected) == true) {
                            print("perangkat kamu sudah terkoneksi");
                          } else {
                            bluetooth.connect(_device!);
                          }
                        } else {
                          print("pilih perangkatmu dulu yuk");
                        }
                      },
                      child: Text(
                        'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        if (_device != null) {
                          bluetooth.disconnect();
                        } else {
                          print("pilih perangkatmu dulu yuk");
                        }
                      },
                      child: Text(
                        'Disconnect',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown),
                    onPressed: () async {
                      ByteData bytesAsset = await rootBundle.load("assets/images/logo.png");
                      Uint8List imageBytesFromAsset =
                          bytesAsset.buffer.asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);

                      if ((await bluetooth.isConnected) == true) {
                        var subtotal = menu.map((e) => e.price * e.qty!).toList();

                        bluetooth.printImageBytes(imageBytesFromAsset);
                        bluetooth.printCustom("ANGKRINGAN CAK PIK", 3, 1);
                        bluetooth.printCustom("------------------------------------------", 0, 1);
                        bluetooth.printNewLine();
                        bluetooth.printCustom("Tanggal    :   ${DateFormat.yMMMEd().format(DateTime.now())}", 0, 0);
                        bluetooth.printCustom("Jam Masuk  :   ${DateFormat.Hms().format(DateTime.now())}", 0, 0);
                        bluetooth.printCustom("Mode       :   Makan Di Tempat", 0, 0);
                        bluetooth.printCustom("Kasir      :   Prabowo Subianto", 0, 0);
                        bluetooth.printCustom("------------------------------------------", 0, 1);
                        for (var a in menu) {
                          bluetooth.printCustom("${a.name} | x${a.qty} | Rp.${a.price}", 0, 0);
                        }
                        bluetooth.printCustom("------------------------------------------", 0, 1);
                        bluetooth.printCustom("Subtotal : Rp.${subtotal.reduce((value, element) => value + element)}", 0, 2);
                        bluetooth.printCustom("------------------------------------------", 0, 1);
                        bluetooth.printNewLine();
                        bluetooth.printNewLine();
                        bluetooth.printNewLine();
                        bluetooth.printNewLine();
                      } else {
                        print("Coba Hubungkan Ke Perangkat Printer Kamu Dulu Ya");
                      }
                    },
                    child: const Text('PRINT TEST', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      for (var device in _devices) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name ?? ""),
        ));
      }
    }
    return items;
  }

  // show(String msg) {
  //   return ScaffoldMessenger(child: Text(msg));
  // }
}

class Product {
  final String name;
  final int price;
  int? qty;

  Product({required this.name, required this.price, this.qty});
}
