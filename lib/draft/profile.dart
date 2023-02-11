import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class Profile extends StatelessWidget{
  final User? user = Auth().currentUser;
  String _controllerEmail = " ";
  int _count = 0;
  // String secEmail = "";
Future<void> signOut() async {
    await Auth().signOut();
  }
// Future <void> _retrievedocc() async {
//     var collection = FirebaseFirestore.instance.collection('users');
//     //reterive the document of the current user
//     var docSnapshot = await collection.doc(user!.uid).get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic> data =
//           docSnapshot.data()!; // convert the document to Map

//       _controllerEmail = data['email'].toString(); // get the value of the phoneVerfied
//       print(_controllerEmail);
//     }
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .collection("projects")
//         .get()
//         .then((value) => {
//               _count = value.docs.length,
//               // value.docs.forEach((result) {
//               //   // print(result.data()["prgress"]);
//               //   // print(result.data()["name"]);
//               //   // print(result.data());
//               //   // print(value.docs.length);
//               // })
//             });
//             print(_count);

//     // FirebaseFirestore.instance
//     //     .collection("users")
//     //     .doc(user?.uid)
//     //     .get()
//     //     .then((value) => secEmail = (value['email']));
//     // print("My email: " + email + " User id " + user!.uid);
//   }

  Future <String> retEmail() async{
    var collection = FirebaseFirestore.instance.collection('users');
    //reterive the document of the current user
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data =
          docSnapshot.data()!; // convert the document to Map

      _controllerEmail = data['email'].toString(); // get the value of the phoneVerfied
      print(_controllerEmail);
    }
    
    return _controllerEmail;
  }

  Future <int> retNumOfProjects() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("projects")
        .get()
        .then((value) => {
              _count = value.docs.length,
              // value.docs.forEach((result) {
              //   // print(result.data()["prgress"]);
              //   // print(result.data()["name"]);
              //   // print(result.data());
              //   // print(value.docs.length);
              // })
            });
    return _count;
  }

  @override
  Widget build(BuildContext context) {
    // _retrievedocc();
    return Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                // Center(
                //   child: Text(
                //     "My Account",
                //     style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
                //     ),
                // ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "My Account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10,),
                // _info(),
                FutureBuilder <String>(
                  future: retEmail(),
                  builder: ((context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(51, 103, 171, 1)
                        ),
                      );
                    }
                    String em = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        // controller: controller,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        readOnly: true,
                        controller: TextEditingController()..text = em,
                      ),
                    );
                  }),
                ),
                FutureBuilder <int>(
                  future: retNumOfProjects(),
                  builder: ((context, snapshot) {
                    if(!snapshot.hasData){
                      return Center();
                    }
                    int countProjects = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        // controller: controller,
                        decoration: InputDecoration(
                          labelText: "Number of projects",
                        ),
                        readOnly: true,
                        controller: TextEditingController()..text = countProjects.toString(),
                      ),
                    );
                  }),
                ),
                // _entryField("Email", _controllerEmail),
                // _entryField("Number of Projects", _count.toString()),

                SizedBox(height: 50,),
                _logoutButton(),
              ],
            ),
          ),
        ),
    );
  }

  Widget _logoutButton(){
    return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      signOut,  
                  child: Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(16)
                        ),
                        backgroundColor: Colors.red[400],
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  ),
                ),
              ],
            ),
          );
  }

  // Widget _entryField(String title,String controller,) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: TextField(
  //       // controller: controller,
  //       decoration: InputDecoration(
  //         labelText: title,
  //       ),
  //       readOnly: true,
  //       controller: TextEditingController()..text = controller,
  //     ),
  //   );
  // }
  
  // Widget _info(){
  //   return Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Card(
  //                   child: Column(
  //                     children: [
  //                       ListTile(
  //                         leading: Icon(Icons.email),
  //                         title: Text(secEmail),
  //                       ),
  //                       Divider(
  //                         height: 1,
  //                         // color: Colors.black87,
  //                         ),
  //                       // Text("data", style: TextStyle()),
  //                       ListTile(
  //                         leading: Icon(Icons.source_rounded),
  //                         title: Text( _count.toString()),
  //                       ),
  //                       Divider(
  //                         height: 1,
  //                         // color: Colors.black87,
  //                         ),
                        
  //                     ],
  //                   ),
  //                 ),
  //               );
  // }
  
}