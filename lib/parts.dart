import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class Parts{
  final int idx;
  final String name;
  final String category;
  final String color;
  final Float rest;
  final String mesg;
  final String location;
  final String id;
  final String image;
  final String wgt;

  Parts({required this.idx, required this.name, required this.category,
  required this.color, required this.rest, required this.mesg, required this.location,
  required this.id, required this.image, required this.wgt
  });

  factory Parts.fromJson(Map<String, dynamic> json) {
    return Parts(
        idx: json['idx'],
        name: json['name'],
        category: json['category'],
        color: json['color'],
        rest: json['rest'],
        mesg: json['mesg'],
        location: json['location'],
        id: json['id'],
        image: json['image'],
        wgt: json['wgt']
    );
  }
}