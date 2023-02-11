import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth.dart';
class Detail extends StatefulWidget {

  String message;
  Detail({required this.message});
  @override
  State<Detail> createState() => _Detail(message);
}

class _Detail extends State<Detail> {

  final User? user = Auth().currentUser;
  String message;
  _Detail(this.message);

  @override
  Widget build(BuildContext context) {
    dynamic iconData;
    dynamic iconColor;

    if(message == "New"){
      iconData = Icons.fiber_new_rounded;
      iconColor = Color.fromARGB(255, 112, 174, 224);
    }
    else if(message == "Completed"){
      iconData = Icons.library_add_check_rounded;
      iconColor = Color.fromARGB(255, 114, 183, 116);
    }
    else if(message == "In-Progress"){
      iconData = Icons.hourglass_bottom_sharp;
      iconColor = Color(0xFFEBBB7F);
    }
    else{
      iconData = Icons.cancel;
      iconColor = Color(0xFFF08A8E);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My Projects"),
        backgroundColor: Color.fromRGBO(51, 103, 171, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("projects").where("status", isEqualTo: message).snapshots(), //.where("name", isEqualTo: "Car")
          builder: (context,snapshot){
            // print(snapshot.data?.docs.length);
            if(snapshot.data?.docs.length == 0 || !snapshot.hasData){
              return Center(
                child: Text("No projects found"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                QueryDocumentSnapshot<Map<String, dynamic>>? u = snapshot.data?.docs[index];
                List<dynamic> ll = snapshot.data?.docs[index]["labels"];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      u!['name'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Progress: "+u['progress'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    leading: Icon(
                      iconData,
                      color: iconColor,
                    ),
                    children: [
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Instructions: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  u['instructions'],
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ),
                            ]
                          ),
                      ),
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Status: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                u['status'],
                                style: TextStyle(color: iconColor),
                              ),
                            ]
                          ),
                      ),
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Progress: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                u['progress'],
                                style: TextStyle(color: iconColor),
                              ),
                            ]
                          ),
                      ),
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Task: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                u['task'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ]
                          ),
                      ),
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Labels: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ll.toString(),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ]
                          ),
                      ),
                      ListTile(
                        title: 
                          Row(
                            children: [
                              Text(
                                "Date Created: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                u['date'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ]
                          ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
