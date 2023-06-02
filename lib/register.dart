import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();

  signUp() async{
    try{
      var res = await http.post(
          Uri.parse(API.signup),
          body: {
            'name' : name.text.trim(),
            'id' : id.text.trim(),
            'pw' : pw.text.trim(),
          });
      if(res.statusCode == 200){
        var resLogin = jsonDecode(res.body);
        if(resLogin['success'] == true){
          Fluttertoast.showToast(msg: 'Welcome to Join!');
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
        }else{
          Fluttertoast.showToast(msg: 'Error Occurred.');
        }
      }
    } catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  validateId() async{
    try{
      var res = await http.post(
          Uri.parse(API.validateId),
          body: {
            'id' : id.text.trim(),
          });
      if(res.statusCode == 200){
        var resvdid = jsonDecode(res.body);
        if(resvdid['existId'] == false){
          Fluttertoast.showToast(msg: 'Available Id');
          signUp();
        }else{
          Fluttertoast.showToast(msg: 'Id already exist');
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Sign Up'),
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
                              primaryColor: Colors.teal,
                              inputDecorationTheme: const InputDecorationTheme(
                                labelStyle: TextStyle(
                                    color: Colors.teal, fontSize: 18.0),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: name,
                                    decoration:
                                        InputDecoration(labelText: 'name'),
                                    keyboardType: TextInputType.text,
                                  ),
                                  TextField(
                                    controller: id,
                                    decoration:
                                        InputDecoration(labelText: 'id'),
                                    keyboardType: TextInputType.text,
                                  ),
                                  TextField(
                                    controller: pw,
                                    decoration:
                                        InputDecoration(labelText: 'password'),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  ButtonTheme(
                                      minWidth: 100.0,
                                      height: 50.0,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          validateId();
                                        },
                                        icon: Icon(Icons.add,
                                            color: Colors.blue, size: 18.0),
                                        label: Text("Submit"),
                                      )),
                                  ButtonTheme(
                                      minWidth: 100.0,
                                      height: 50.0,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
                                        },
                                        icon: Icon(Icons.add,
                                            color: Colors.blue, size: 18.0),
                                        label: Text("Cancel"),
                                      ))
                                ],
                              ),
                            )))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
