import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'package:labelapp/pages/signuplogin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Sign up');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }
  Widget _img() {
    return (
      Column(
        children: [
          Image.asset(
            'images/Logo2.png',
            height: 120,
            fit: BoxFit.fitWidth,
            ),
        ],
      )
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
        signInWithEmailAndPassword,  
      child: Text(
        'Login',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(16)
            ),
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }
  // Widget _dontHaveAccount(){
  //   return TextButton(
  //     onPressed: (){},
  //     child: Text("Don't have account?"),
  //   );
  // }
  Widget _dontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black),
          ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));

          },
          child: const Text(
            "Sign up",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   title: _title(),
      // ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child:
                  _img(),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
                    ),
                _entryField('Email', _controllerEmail),
                _entryField('Password', _controllerPassword),
                _errorMessage(),
                _submitButton(),
                SizedBox(height: 10,),
                _dontHaveAccount()
              ]
              ),
          ),
      ),
      ),
      
    );
  }
}
