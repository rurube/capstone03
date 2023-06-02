import 'dart:convert';
import 'mylist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'package:image_picker/image_picker.dart';

class listregister extends StatefulWidget {
  final String id;
  const listregister(this.id, {super.key});

  @override
  State<listregister> createState() => _listregisterState();
}

class _listregisterState extends State<listregister> {

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController loc = TextEditingController();
  String baseimage = base64Encode(imageBytes);

  partsInsert() async{
    try{
      var res = await http.post(
          Uri.parse(API.partsinsert),
          body: {
            'id' : widget.id,
            'name' : name.text.trim(),
            'category':category.text.trim(),
            'color':color.text.trim(),
            'mesg':description.text,
            'location':loc,
            'wgt':0,
            'image':baseimage,
          });
      if(res.statusCode == 200){
        var respin = jsonDecode(res.body);
        if(respin['success'] == true){
          Fluttertoast.showToast(msg: 'Insert Success');
          var id = widget.id;
          Navigator.push(context, MaterialPageRoute(builder: (context) => List(id)));
        }else{
          Fluttertoast.showToast(msg: 'error');
        }
      }
    } catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'List Register',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  const Center(),
                  Form(
                      child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.lightBlueAccent,
                            inputDecorationTheme: const InputDecorationTheme(
                              labelStyle:
                                  TextStyle(color: Colors.teal, fontSize: 18.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  label: Text('Add image'),
                                  icon: Icon(Icons.image),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  controller: name,
                                  decoration:
                                      InputDecoration(labelText: 'name'),
                                  keyboardType: TextInputType.text,
                                ),
                                TextField(
                                  controller: description,
                                  decoration:
                                      InputDecoration(labelText: 'description'),
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text('register'),
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
