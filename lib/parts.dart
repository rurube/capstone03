import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class Parts{
   //String idx;
   String name;
   String category;
   //String color;
   //String rest;
   //String mesg;
   //String location;
   //String id;
   var image;
   //String wgt;

  //Parts({required this.idx, required this.name, required this.category, required this.color, required this.rest, required this.mesg, required this.location, required this.id, required this.image, required this.wgt});
  Parts({required this.name, required this.category, required this.image});
  factory Parts.fromJson(Map<String, dynamic> json) {
    return Parts(
        //idx: json['idx'],
        name: json['name'],
        category: json['category'],
        //color: json['color'],
        //rest: json['rest'],
        //mesg: json['mesg'],
        //location: json['location'],
        //id: json['id'],
        image: json['image'],
        //wgt: json['wgt']
    );
  }
}