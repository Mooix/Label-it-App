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
