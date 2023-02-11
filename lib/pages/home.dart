import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labelapp/pages/profile.dart';
import '../auth.dart';
import 'Tasks.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final User? user = Auth().currentUser;

  void retrieveone() {
    FirebaseFirestore.instance.collection("users").get().then((value) => {
          value.docs.forEach((result) {
            print(result.data());
          })
        });
  }

  List pr = [];
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
                // print(result.data());
                pr.add(result.data());
              })
            });
        print(pr);
  }

  void retrievedoc() {
    // var us = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) => print(value.data()));
  }

  void retCondition() {
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: "mp@gmail.com")
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.id);
                print(element.data());
              })
            });
  }

  void retrievedoc2() {
    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: user?.uid)
        .get()
        .then((value) => print(value.docs.toString()));
  }

  void test() async {
    var email;
    var collection = FirebaseFirestore.instance.collection('users');
    //reterive the document of the current user
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data =
          docSnapshot.data()!; // convert the document to Map

      email = data['email']; // get the value of the phoneVerfied
    }

    print("My email: " + email + " User id " + user!.uid);
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;

  List<Widget> widgetPages = [
    Homepage(),
    const Profile()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromRGBO(51, 103, 171, 1),
        onTap: (value) {
          setState((){
            selectedIndex =value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home", icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: "Profile", icon: Icon(Icons.person)
          ),
        ],
      ),
      body: widgetPages.elementAt(selectedIndex),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(51, 103, 171, 1), //rgb(51, 103, 171) #3367AB
      elevation: 0, // no shadow
      title: Row(
        children: [
          Text(
            'Label it',
          )
        ],
      ),
    );
  }
}

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(30),
          child: Text(
            "Projects",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Tasks(),
        ),
      ],
    );
  }
}










////////////////////////////////////////////////////////////////
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:labelapp/pages/profile.dart';
// import '../auth.dart';
// import 'Tasks.dart';

// class Home extends StatefulWidget {
//   Home({super.key});

//   final User? user = Auth().currentUser;
//   // int selectedIndex = 0;
//   void retrieveone() {
//     FirebaseFirestore.instance.collection("users").get().then((value) => {
//           value.docs.forEach((result) {
//             print(result.data());
//           })
//         });
//   }
//   List pr = [];
//   void retrievesub() {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .collection("projects")
//         .get()
//         .then((value) => {
//               value.docs.forEach((result) {
//                 // print(result.data()["prgress"]);
//                 // print(result.data()["name"]);
//                 // print(result.data());
//                 pr.add(result.data());
//               })
//             });
//         print(pr);
//   }
//   void retrievedoc() {
//     // var us = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user?.uid)
//         .get()
//         .then((value) => print(value.data()));
//   }

//   void retCondition() {
//     FirebaseFirestore.instance
//         .collection("users")
//         .where("email", isEqualTo: "mp@gmail.com")
//         .get()
//         .then((value) => {
//               value.docs.forEach((element) {
//                 print(element.id);
//                 print(element.data());
//               })
//             });
//   }

//   void retrievedoc2() {
//     // var us = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection("users")
//         .where("uid", isEqualTo: user?.uid)
//         .get()
//         .then((value) => print(value.docs.toString()));
//   }
//   void test() async {
//     var email;

//     var collection = FirebaseFirestore.instance.collection('users');
//     //reterive the document of the current user
//     var docSnapshot = await collection.doc(user!.uid).get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic> data =
//           docSnapshot.data()!; // convert the document to Map

//       email = data['email']; // get the value of the phoneVerfied
//     }

//     print("My email: " + email + " User id " + user!.uid);
//   }


//   // Future<void> signOut() async {
//   //   await Auth().signOut();
//   // }

//   // Widget _title() {
//   //   return const Text('Firebase Auth');
//   // }

//   // Widget _userUid() {
//   //   return Text(user?.email ?? 'User email');
//   // }
//   // Widget _signOutButton() {
//   //   return ElevatedButton(
//   //     onPressed: retrievesub,
//   //     child: const Text('Sign Out'),
//   //   );
//   // }
  
  
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
  
//   int selectedIndex = 0;
//   List<Widget> widgetPages = [
//     Homepage(),
//     const Profile()
//   ];
//   // void _onItemTapped(int index) {
//   //   setState(() {  
//   //     selectedIndex = index;  
//   //   });  
//   // }

//   // Future<void> signOut() async {
//   //   await Auth().signOut();
//   // }
  
//   @override
//   Widget build(BuildContext context) {
//   // final User? user = Auth().currentUser;
//   // var email;
//   // Future<void> retrievedoc() async {
//   //   var collection = FirebaseFirestore.instance.collection('users');
//   //   //reterive the document of the current user
//   //   var docSnapshot = await collection.doc(user!.uid).get();
//   //   if (docSnapshot.exists) {
//   //     Map<String, dynamic> data =
//   //         docSnapshot.data()!; // convert the document to Map

//   //     email = data['email']; // get the value of the phoneVerfied
//   //   }

//   //   print("My email: " + email + " User id " + user!.uid);
//   // }
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         currentIndex: selectedIndex,
//         // selectedItemColor: Colors.green,
//         onTap: (value) {
//           setState((){
//             selectedIndex =value;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             label: "Home", icon: Icon(Icons.home)
//           ),
//           BottomNavigationBarItem(
//             label: "Profile", icon: Icon(Icons.person)
//           ),
//         ],
//       ),
//       body: widgetPages.elementAt(selectedIndex),
//     );
//   }
//   AppBar _buildAppBar() {
//     return AppBar(
//       // backgroundColor: Color.fromARGB(255, 60, 91, 213),
//       backgroundColor: const Color.fromRGBO(51, 103, 171, 1), //rgb(51, 103, 171) #3367AB
//       elevation: 0, // no shadow
//       title: Row(
//         children: [
//           // Container(
//           //   height: 45,
//           //   width: 45,
//           //   // margin: EdgeInsets.only(left: 15), // margin left
//           //   child: ClipRRect(
//           //     borderRadius: BorderRadius.circular(10),
//           //     child: Image.asset('images/Logo2.png'),
//           //   ),
//           // ),
//           // SizedBox(width: 5),
//           Text(
//             'Label it',
//             // style: TextStyle(
//             //     color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold,),
//           )
//         ],
//       ),
//       // actions: [Icon(Icons.logout, color: Colors.black, size: 40)],
//       // actions: <Widget>[
//       //   Padding(
//       //     padding: const EdgeInsets.only(right: 10),
//       //     child: GestureDetector(
//       //       onTap: signOut,
//       //       child: Icon(Icons.logout, color: Colors.white, size:30),
//       //     ),
//       //   )
//       // ],
//     );
//   }
// }


// // class PageTwo extends StatelessWidget{
// //   final User? user = Auth().currentUser;
// //   String _controllerEmail = " ";
// //   int _count = 0;
// // Future<void> signOut() async {
// //     await Auth().signOut();
// //   }
// // Future <void> _retrievedocc() async {
// //     String email = "";
// //     int count;
// //     var collection = FirebaseFirestore.instance.collection('users');
// //     //reterive the document of the current user
// //     var docSnapshot = await collection.doc(user!.uid).get();
// //     if (docSnapshot.exists) {
// //       Map<String, dynamic> data =
// //           docSnapshot.data()!; // convert the document to Map

// //       _controllerEmail = data['email'].toString(); // get the value of the phoneVerfied
// //       print(_controllerEmail);
// //     }
// //     FirebaseFirestore.instance
// //         .collection("users")
// //         .doc(user!.uid)
// //         .collection("projects")
// //         .get()
// //         .then((value) => {
// //               _count = value.docs.length,
// //               value.docs.forEach((result) {
// //                 // print(result.data()["prgress"]);
// //                 // print(result.data()["name"]);
// //                 // print(result.data());
// //                 // print(value.docs.length);
// //               })
// //             });
// //             print(_count);
// //     // print("My email: " + email + " User id " + user!.uid);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     _retrievedocc();
// //     // return Padding(
// //     //   padding: EdgeInsets.all(8),
// //     //   child: Center(
// //     //     child: Column(
// //     //       children: [
// //     //         ListTile(
// //     //           leading: Icon(Icons.email),
// //     //           title: Text(_controllerEmail),
// //     //         ),
// //     //       ],
// //     //     ),
// //     //   ),
// //     // );
// //     return Container(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: EdgeInsets.only(top: 20),
// //             child: Column(
// //               children: <Widget>[
// //                 Center(
// //                   child: Text(
// //                     "My Account",
// //                     style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
// //                     ),
// //                 ),
// //                 SizedBox(height: 10,),
// //                 _info(),
// //                 SizedBox(height: 50,),
// //                 _logoutButton()
// //               ]
// //             ),
// //           ),
// //         ),
// //     );
// //   }
// //   Widget _info(){
// //     return Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Card(
// //                     child: Column(
// //                       children: [
// //                         ListTile(
// //                           leading: Icon(Icons.email),
// //                           title: Text(_controllerEmail),
// //                         ),
// //                         Divider(
// //                           height: 1,
// //                           // color: Colors.black87,
// //                           ),
// //                         // Text("data", style: TextStyle()),
// //                         ListTile(
// //                           leading: Icon(Icons.source_rounded),
// //                           title: Text( _count.toString()),
// //                         ),
// //                         Divider(
// //                           height: 1,
// //                           // color: Colors.black87,
// //                           ),
                        
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //   }
// //   Widget _logoutButton(){
// //     return Container(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed:
// //                       signOut,  
// //                   child: Text(
// //                     "Logout",
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                     ),
// //                     style: ElevatedButton.styleFrom(
// //                     shape: RoundedRectangleBorder( //to set border radius to button
// //                             borderRadius: BorderRadius.circular(16)
// //                         ),
// //                         backgroundColor: Colors.red[400],
// //                         padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //   }
// // }



// class Homepage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(30),
//             child: Text(
//               "Projects",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: Tasks(),
//             ),
          
//           // ElevatedButton(
//           //   onPressed: (){
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => SecDetail(),
//           //     ));
//           //   },
//           //   child: const Text('Sign Ou'),
//           // )
//         ],
//         );
//   }
// }