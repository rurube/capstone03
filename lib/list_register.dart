import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
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
  Rx<XFile> image = XFile('').obs;
  RxBool isPicked = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController loc = TextEditingController();

  getImage({required bool isCamera}) async {
    XFile? _file;

    if (isCamera) {
      _file = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (_file != null) {
      image.value = XFile(_file.path);
      isPicked.value = true;
    }
  }

  partsInsert() async {
    String encodeImage = "";
    if (image.value.path.isNotEmpty) {
      Uint8List bytes = await image.value.readAsBytes();
      encodeImage = base64Encode(bytes);
      try {
        var res = await http.post(Uri.parse(API.partsinsert), body: {
          'id': widget.id,
          'name': name.text.trim(),
          'image': encodeImage,
          'category': category.text.trim(),
          'color': color.text.trim(),
          'mesg': description.text,
          'location': loc.text,
          'wgt': '0',
        });
        if (res.statusCode == 200) {
          var respin = jsonDecode(res.body);
          if (respin['success'] == true) {
            Fluttertoast.showToast(msg: 'Insert Success');
            var id = widget.id;
            Navigator.push(context, MaterialPageRoute(builder: (context) => List(id)));
          } else {
            print(loc.text);
            Fluttertoast.showToast(msg: 'error');
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Image not Selected");
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
                                CircleAvatar(
                                  radius: Get.size.height * 0.09,
                                  backgroundImage: isPicked.value
                                      ? FileImage(File(image.value.path))
                                      : null,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        getImage(isCamera: true);
                                      },
                                      child: Text('Camera'),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        getImage(isCamera: false);
                                      },
                                      child: Text('Gallery'),
                                    )
                                  ],
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
                                TextField(
                                  controller: category,
                                  decoration:
                                      InputDecoration(labelText: 'category'),
                                  keyboardType: TextInputType.text,
                                ),
                                TextField(
                                  controller: color,
                                  decoration:
                                      InputDecoration(labelText: 'color'),
                                  keyboardType: TextInputType.text,
                                ),
                                TextField(
                                  controller: loc,
                                  decoration:
                                      InputDecoration(labelText: 'location'),
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      partsInsert();
                                    },
                                    child: Text('Insert'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      var id = widget.id;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => List(id)));
                                    },
                                    child: Text('Cancle'),
                                  )
                                ]),
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
