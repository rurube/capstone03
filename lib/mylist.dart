import 'dart:convert';
import 'package:capstone_design_project/partslist.dart';
import 'package:flutter/material.dart';
import 'package:capstone_design_project/list_register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'parts.dart';
class List extends StatefulWidget {
  final String idtext;
  const List(this.idtext, {super.key});


  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {

  Future<Names> getList() async{
    var resName;
    late Names names;
    try{
      var res = await http.post(
        Uri.parse(API.callinfo),
        body:{
          'id' : widget.idtext,
        });
        resName = jsonDecode(res.body);
        names = Names(
          username: resName[0]["name"],);
    }catch(e){
      print(e);
    }
    return names;
  }

  Future<List> getParts() async{
    var response = await http.post(Uri.parse(API.partsload), body:{'id':widget.idtext},);
    if (response.statusCode == 200) {

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      Future<List> partList = items.map<Parts>((json) {
        return Parts.fromJson(json);
      }).toList();

      return partList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  var titleList = [
    'Dentist',
    'Pharmacist',
    'IT manager',
    'Web designer'
  ];

  var imageList = [
    'image/games.png',
    'image/swimmer.png',
    'image/swimming (1).png',
    'image/swimming (2).png'
  ];

  var description = [
    '1. There are different types of careers you can pursue in your life.',
    '2. There are different types of careers you can pursue in your life.',
    '3. There are different types of careers you cna pursue in your life.',
    '4. There are different types of careers you cna pursue in your life.'
  ];

  void showPopup(context, title, image, description) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            height: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
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
                      color: Colors.grey
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    description,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500]
                    ),
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
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ItemList',
          style: TextStyle(
            color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        iconTheme: IconThemeData(
          color: Colors.blue),
      ),
      body: FutureBuilder<List<Parts>>(
        future: getParts(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Center(
            child: CircularProgressIndicator(),
          );
          return ListView(
            children: snapshot.data
            .map((data)=>Column(children: <Widget> [
              GestureDetector(
                onTap: (){showPopup(context, data.name, data.image, data.msg);},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                    child: Text(data.username,
                    style: TextStyle(fontSize: 21),
                        textAlign: TextAlign.left))
                  ],),),
            ],)),
          );
        },
      ),
      drawer: Drawer(
        child:FutureBuilder(
          future: getList(),
          builder: (context, AsyncSnapshot<Names> snapshot){
            if(snapshot.hasData == false){
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
                  onDetailsPressed:(){
                    print('arrow is clicked');
                  },
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      )
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,
                    color: Colors.grey[850],
                  ),
                  title: Text('Home'),
                  onTap: (){
                    print('Home is clicked');
                  },
                  trailing: Icon(Icons.add),
                ),
                ListTile(
                  leading: Icon(Icons.settings,
                    color: Colors.grey[850],
                  ),
                  title: Text('Setting'),
                  onTap: (){
                    print('Setting is clicked');
                  },
                  trailing: Icon(Icons.add),
                ),
                ListTile(
                  leading: Icon(Icons.question_answer,
                    color: Colors.grey[850],),
                  title: Text('Q&A'),
                  onTap: (){
                    print('Q&A is clicked');
                  },
                  trailing: Icon(Icons.add),
                ),
              ],
            );
          },
        )
      ),
    );
  }}