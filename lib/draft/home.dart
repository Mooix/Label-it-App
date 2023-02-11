import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_project/auth.dart';
import 'package:flutter/material.dart';
import 'package:labelapp/pages/details.dart';
import '../auth.dart';
import '../pages/Tasks.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  int selectedIndex = 0;
  void retrieveone() {
    FirebaseFirestore.instance.collection("users").get().then((value) => {
          value.docs.forEach((result) {
            print(result.data());
          })
        });
  }

// retrievesub
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
    // var us = FirebaseAuth.instance.currentUser;
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


  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: retrievesub,
      child: const Text('Sign Out'),
    );
  }
  // void _onItemTapped(int index) {
  //   setState(() {  
  //     selectedIndex = index;  
  //   });  
  // }

  // @override
  // Widget build(BuildContext context) {
  //   //  test();
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: _title(),
  //     ),
  //     body: Container(
  //       height: double.infinity,
  //       width: double.infinity,
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           _userUid(),
  //           _signOutButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              
            },
            items: [
              BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                label: "Profile", icon: Icon(Icons.ac_unit)
              ),
            ],
          ),
      body: Column(
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
          
          // ElevatedButton(
          //   onPressed: (){
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => SecDetail(),
          //     ));
          //   },
          //   child: const Text('Sign Ou'),
          // )
        ],
        ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 60, 91, 213),
      elevation: 0, // no shadow
      title: Row(
        children: [
          // Container(
          //   height: 45,
          //   width: 45,
          //   // margin: EdgeInsets.only(left: 15), // margin left
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Image.asset('images/Logo2.png'),
          //   ),
          // ),
          // SizedBox(width: 5),
          Text(
            'Hi, Mohanned',
            style: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold,),
          )
        ],
      ),
      // actions: [Icon(Icons.logout, color: Colors.black, size: 40)],
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: signOut,
            child: Icon(Icons.logout, color: Colors.white, size:30),
          ),
        )
      ],
    );
  }

}
