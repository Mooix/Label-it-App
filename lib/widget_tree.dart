import 'package:labelapp/auth.dart';
import 'package:flutter/material.dart';
import 'package:labelapp/pages/home.dart';
import 'package:labelapp/pages/signuplogin.dart';



class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const Signup();
        }
      },
    );
  }
}
