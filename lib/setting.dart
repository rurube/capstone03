import 'package:flutter/material.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({Key? key}) : super(key: key);

  @override
  State<Settingpage> createState() => _SettingpageState();
}

TextEditingController setpoint1 = TextEditingController();
TextEditingController setpoint2 = TextEditingController();

class _SettingpageState extends State<Settingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          iconTheme: IconThemeData(
              color: Colors.blue),
          title: Text('Setting',
            style: TextStyle(
                color: Colors.blue),
          ),
        ),
        body: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text('기본 설정은 30%,70%입니다.',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        TextField(
                          controller: setpoint1,
                          decoration:
                          InputDecoration(labelText: 'setpoint1'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: setpoint2,
                          decoration:
                          InputDecoration(labelText: 'setpoint2'),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,

                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add,
                                color: Colors.blue, size: 18.0),
                            label: Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },));
  }}