import 'dart:convert';
import 'package:capstone_design_project/partslist.dart';
import 'package:capstone_design_project/setting.dart';
import 'package:flutter/material.dart';
import 'package:capstone_design_project/list_register.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'connect.dart';
import 'parts.dart';
import 'main.dart';
import 'ble_provider.dart';
import 'package:provider/provider.dart';
import 'package:capstone_design_project/ble_provider.dart';

class Mylist extends StatefulWidget {
  final String idtext;
  const Mylist(this.idtext, {super.key});

  @override
  State<Mylist> createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  var _maxItem;
  late Future<List<Parts>> futurelist;
  late BleProvider _bleProvider;


  @override
  void initState() {
    super.initState();
    futurelist = getParts();
  }
  Future<Names> getList() async {
    var resName;
    late Names names;
    try {
      var res = await http.post(Uri.parse(API.callinfo), body: {
        'id': widget.idtext,
      });
      resName = jsonDecode(res.body);
      names = Names(
        username: resName[0]["name"],
      );
    } catch (e) {
      print(e);
    }
    return names;
  }

  Future<List<Parts>> getParts() async {
    List<Parts> list = [];
    var response = await http.post(
      Uri.parse(API.partsload),
      body: {'id': widget.idtext},
    );
    if (response.statusCode == 200) {
      final result = utf8.decode(response.bodyBytes);
      List<dynamic> json = jsonDecode(result);
      _maxItem = json.length;

      for (int i = 0; i < json.length; i++) {
        list.add(Parts.fromJson(json[i]));
      }
      setState(() {});
      return list;
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load Parts');
    }
  }

  void showPopup(context, title, image, description) {
    _bleProvider = Provider.of<BleProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    image,
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    description,
                    maxLines: 3,
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('close'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _bleProvider.setService();
                    _bleProvider.sendMessage(_bleProvider.bluetoothService, 1);
                  },
                  icon: Icon(Icons.add),
                  label: const Text('led on'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ItemList',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: _maxItem == null ? 0 : _maxItem * 2,
        itemBuilder: (context, index){
          if(index.isOdd){
            return const Divider();
          }
          return _getSheet(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var id = widget.idtext;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Listregister(id)));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),

      ),
      drawer: Drawer(
          child: FutureBuilder(
        future: getList(),
        builder: (context, AsyncSnapshot<Names> snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('image/games.png'),
                  backgroundColor: Colors.white,
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/swimmer.png'),
                    backgroundColor: Colors.white,
                  ),
                  // CircleAvatar(
                  //   backgroundImage: AssetImage('assets/swimmer.png'),
                  //   backgroundColor: Colors.white,
                  // ),
                ],
                accountName: Text('${snapshot.data?.username.toString()}'),
                accountEmail: Text(widget.idtext),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    )),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[850],
                ),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('Setting'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Settingpage()));
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.grey[850],
                ),
                title: Text('Connect'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Conn()));
                },
                trailing: Icon(Icons.add),
              ),
            ],
          );
        },
      )),
    );
  }

  Widget _getSheet(index) {
    return FutureBuilder<List<Parts>>(
      future: futurelist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data![index ~/ 2];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.category),
            leading: Image.memory(base64Decode(item.image)),
            onTap: (){
              showPopup(context, item.name, base64Decode(item.image), item.category);
            },
          );
        } else if (snapshot.hasError) {
          print("${snapshot.error}");
        }
        return ListTile(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
