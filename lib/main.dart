import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dice.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();

  userLogin() async{
    try{
      var res = await http.post(
        Uri.parse(API.signin),
        body: {
          'id' : controller.text.trim(),
          'pw' : controller2.text.trim()
        });
      if(res.statusCode == 200){
        var resLogin = jsonDecode(res.body);
        if(resLogin['success'] == true){
          Fluttertoast.showToast(msg: 'Login successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dice()));
        }else{
          Fluttertoast.showToast(msg: 'Please check your email and password');
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
        title: Text('2023 캡스톤 디자인'),
        centerTitle: true,
        elevation: 0.0,

        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              print('shopping cart button is clicked');
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('search button is clicked');
            },
          ),
        ],
      ),
      body: Builder(
        builder:(context) {
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Center(
                    child: Image(
                      image: AssetImage('image/drawers.png'),
                      width: 170.0,
                      height: 190.0,
                    ),
                  ),
                  Form(
                      child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.teal,
                            inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      labelText: 'ID'
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextField(
                                  controller: controller2,
                                  decoration: InputDecoration(
                                      labelText: 'Password'
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                SizedBox(height: 40.0,),
                                ButtonTheme(
                                    minWidth: 100.0,
                                    height: 50.0,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.lightBlue,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: Icon(Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 35.0,
                                        ),
                                        onPressed: () {
                                          userLogin();
                                          })),
                                ButtonTheme(
                                    minWidth: 100.0,
                                    height: 50.0,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                      },
                                      icon: Icon(Icons.add,
                                      color: Colors.blue,
                                      size: 18.0),
                                      label: Text("Sign Up"),
                                        ))
                              ],
                            ),
                          ))
                  )
                ],
              ),
            ),
          );
        },
      ),

    );
  }



}
