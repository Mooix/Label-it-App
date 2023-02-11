import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgcolor;
  Color? iconColor;
  Color? btnColor;

  Task({this.iconData, this.title, this.bgcolor, this.iconColor, this.btnColor});
  static List <Task> generateTasks(){
    return [
      Task(
        iconData:Icons.fiber_new_rounded,
        title: 'New',
        // bgcolor: Color.fromARGB(255, 169, 221, 245),
        bgcolor: Colors.blue[50],
        iconColor: Color.fromARGB(255, 112, 174, 224),
        btnColor: Colors.white
      ),
      Task(
        iconData:Icons.library_add_check_rounded,
        title: 'Completed',
        bgcolor: Color.fromARGB(255, 225, 248, 199),
        iconColor: Color.fromARGB(255, 114, 183, 116),
        btnColor: Colors.white
      ),
      Task(
        iconData:Icons.hourglass_bottom_sharp,
        title: 'In-Progress',
        bgcolor: Color(0xFFFFF7EC),
        iconColor: Color(0xFFEBBB7F),
        btnColor: Colors.white
      ),
      Task(
        iconData:Icons.cancel,
        title: 'Canceled',
        bgcolor: Color(0xFFFCF0F0),
        iconColor: Color(0xFFF08A8E),
        btnColor: Colors.white
      )
    ];
  }
}