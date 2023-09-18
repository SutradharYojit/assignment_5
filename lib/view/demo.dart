import 'dart:developer';

import 'package:intl/intl.dart';

// import 'package:flutter/material.dart';
void main(){
  final dateFormat = DateFormat('h:mm a');
  final DateTime timeStamp = DateTime.now();
  print(timeStamp);
  print(timeStamp.millisecondsSinceEpoch);
  int time=timeStamp.millisecondsSinceEpoch;

    final date1=DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(time));
  print(date1.toString());
  print(date1.runtimeType);


}