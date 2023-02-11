import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
class Details extends StatelessWidget {
  Details({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  
  void retrievesub() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("projects")
        .get()
        .then((value) => {
              value.docs.forEach((result) {
                // print(result.data()["prgress"]);
                // print(result.data()["name"]);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 231),
      appBar: AppBar(
        title: Text("Your Projects"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView (
          children: [
            Container(
              // elevation: 2, with card instead of container
              margin: EdgeInsets.only(bottom: 20),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   color: Colors.white,
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  "Project Name",
                  ),
                subtitle: Text("Project Progress"),
                trailing: Icon(Icons.arrow_forward_ios),
                contentPadding: EdgeInsets.all(10),
                // onTap: (){print("clicked");},
                leading: Icon(
                  Icons.hourglass_bottom_sharp,
                  color: Colors.amber,
                  ),
              ),
            ),
            Container(
              // elevation: 2, with card instead of container
              margin: EdgeInsets.only(bottom: 20),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   color: Colors.white,
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  "Project Name",
                  ),
                subtitle: Text("Project Progress"),
                trailing: Icon(Icons.arrow_forward_ios),
                contentPadding: EdgeInsets.all(10),
                // onTap: (){print("clicked");},
                leading: Icon(
                  Icons.hourglass_bottom_sharp,
                  color: Colors.amber,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           StreamBuilder(
  //             stream: ,
  //             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
  //               if(!snapshot..hasData)
  //             },
  //             ),
  //           ),
  //         ],
  //         ),
  //     ),
  //   );
  // }
}