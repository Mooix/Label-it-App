import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  final TextEditingController _controllerEmail = TextEditingController();

  Future passwordReset() async {
    try{
      await FirebaseAuth.instance
      .sendPasswordResetEmail(email: _controllerEmail.text.trim());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return CupertinoAlertDialog(
            content: Text("Password reset link sent! Check your Email"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text("OK")
              )
            ],
          );
        }
      );
    } on FirebaseAuthException catch (e){
        showDialog(
          context: context,
          builder: (context){
            return CupertinoAlertDialog(
              content: Text(e.message.toString()),
            );
          }
        );
      }
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
        passwordReset,  
      child: Text(
        'Reset Password',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(16)
              ),
        backgroundColor: Color.fromRGBO(51, 103, 171, 1),
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      ),
    );
  }

  Widget _entryField() {
    return TextField(
      controller: _controllerEmail,
      decoration: InputDecoration(
        labelText: "Email",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 103, 171, 1),
        elevation: 0,
      ),
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
                  "Reset Password",
                  style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
                ),
                SizedBox(height: 20,),
                _entryField(),
                SizedBox(height: 20,),
                _submitButton(),
                SizedBox(height: 20,),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
