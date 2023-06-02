
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class listregister extends StatefulWidget {
  const listregister({Key? key}) : super(key: key);

  @override
  State<listregister> createState() => _listregisterState();
}

TextEditingController name = TextEditingController();
TextEditingController description = TextEditingController();

class _listregisterState extends State<listregister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        iconTheme: IconThemeData(
            color: Colors.blue),
        title: Text('List Register',
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
    child: Column(
    children: [
    const Padding(padding: EdgeInsets.only(top: 50)),
    const Center(),
    Form(
    child: Theme(
    data: ThemeData(
    primaryColor: Colors.lightBlueAccent,
    inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
    color: Colors.teal, fontSize: 18.0),
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
    onPressed: (){},
    label: Text('Add image'),
    icon: Icon(Icons.image),),
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
        onPressed: (){},
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
    ),);
  }

}
