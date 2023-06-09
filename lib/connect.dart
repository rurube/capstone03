import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'device_screen.dart';
class Conn extends StatefulWidget {

  const Conn({Key? key}) : super(key: key);

  @override
  State<Conn> createState() => ConnState();
}

class ConnState extends State<Conn> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResultList = [];

  int scan_mode = 2;   // scan mode
  bool isScanning = false;

  /* 생성자 */
  @override
  void initState() {
    super.initState();
  }

  /* 시작, 정지 */
  void toggleState() {
    isScanning = !isScanning;

    if (isScanning) {
      flutterBlue.startScan(
          scanMode: ScanMode(scan_mode), allowDuplicates: true);
      scan();
    } else {
      flutterBlue.stopScan();
    }
    setState(() {});
  }

  /*
  Scan Mode
  Ts = scan interval
  Ds = duration of every scan window
             | Ts [s] | Ds [s]
  LowPower   | 5.120  | 1.024
  BALANCED   | 4.096  | 1.024
  LowLatency | 4.096  | 4.096

  LowPower = ScanMode(0);
  BALANCED = ScanMode(1);
  LowLatency = ScanMode(2);

  opportunistic = ScanMode(-1);
   */

  /* Scan */
  void scan() async {
    if (isScanning) {
      // Listen to scan results

      flutterBlue.scanResults.listen((results) {
        // do something with scan results
        scanResultList = results;
        // update state
        setState(() {});
      });
    }
  }

  /* 장치의 RSSI */
  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  /* 장치의 MAC 주소 위젯  */
  Widget deviceMacAddress(ScanResult r) {
    return Text(r.device.id.id);
  }

  /* 장치의 명 위젯  */
  Widget deviceName(ScanResult r) {
    String name;

    if (r.device.name.isNotEmpty) {
      // device.name에 값이 있다면
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      // advertisementData.localName에 값이 있다면
      name = r.advertisementData.localName;
    } else {
      // 둘다 없다면 이름 알 수 없음...
      name = 'N/A';
    }
    return Text(name);
  }

  /* BLE 아이콘 위젯 */
  Widget leading(ScanResult r) {
    return const CircleAvatar(
      backgroundColor: Colors.cyan,
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
    );
  }
  /* 장치 아이템을 탭 했을때 호출 되는 함수 */
  void onTap(ScanResult r) {
    // 단순히 이름만 출력
    print('${r.device.name}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeviceScreen(device: r.device)),
    );

  }

  /* 장치 아이템 위젯 */
  Widget listItem(ScanResult r) {
    return ListTile(
      onTap: () => onTap(r),
      leading: leading(r),
      title: deviceName(r),
      subtitle: deviceMacAddress(r),
      trailing: deviceSignal(r),
    );
  }

  /* UI */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bluetooth'),
      ),
      body: Center(
        /* 장치 리스트 출력 */
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return listItem(scanResultList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
      /* 장치 검색 or 검색 중지  */
      floatingActionButton: FloatingActionButton(
        onPressed: toggleState,
        // 스캔 중이라면 stop 아이콘을, 정지상태라면 search 아이콘으로 표시
        child: Icon(isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}



