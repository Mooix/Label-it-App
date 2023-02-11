import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'ForgotPasswordPage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title,TextEditingController controller) {
    return TextField(
      obscureText: title == "Password" ? true : false,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _forgetpass(bool isloginbol){
    return (
      isloginbol ? 
        (Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ForgotPasswordPage();
                    },
                    ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                )
              ],
            )
        ) : (Center())
    );
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

  bool? _ischecked = true;
  Widget _checkboxagreement(bool isloginbol){
    return (
      !isloginbol ? 
        (Center(
                  child: CheckboxListTile(
                    title: const Text("I agree to Labelit's terms and conditions"),
                    value: _ischecked,
                    onChanged: (newvalue){
                      setState(() {
                        _ischecked = newvalue;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                )
        ): Center());
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
        isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,  
      child: Text(
        isLogin ? 'Login' : 'Signup',
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

  Widget _dontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin? "Don't have an account? ":"Already have account? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin? "Signup" : "Login",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child: _img(),
                ),
                SizedBox(height: 30,),
                Text(
                  isLogin? "Login":"Signup",
                  style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
                ),
                _entryField('Email', _controllerEmail),
                _entryField('Password', _controllerPassword),
                SizedBox(height: 10,),
                _forgetpass(isLogin),
                _errorMessage(),
                _checkboxagreement(isLogin),
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








////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../auth.dart';
// import 'ForgotPasswordPage.dart';

// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   String? errorMessage = '';
//   bool isLogin = true;

//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   Future<void> signInWithEmailAndPassword() async {
//     try {
//       await Auth().signInWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }
//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await Auth().createUserWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//       //  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   // Widget _title() {
//   //   return const Text('Sign up');
//   // }

//   Widget _entryField(String title,TextEditingController controller) {
//     return TextField(
//       obscureText: title == "Password" ? true : false,
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: title,
//       ),
//     );
//   }
//   Widget _errorMessage() {
//     return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
//   }
//   Widget _forgetpass(bool isloginbol){
//     return (
//     isloginbol ? 
//     (Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context){
//                   return ForgotPasswordPage();
//                 },
//                 ),
//                 );
//               },
//               child: Text(
//                 "Forgot Password?",
//                 style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                 ),
//             )
//           ],
//         )) : (Center())
//     );
//   }
//   Widget _img() {
//     return (
//       Column(
//         children: [
//           Image.asset(
//             'images/Logo2.png',
//             height: 120,
//             fit: BoxFit.fitWidth,
//             ),
//         ],
//       )
//     );
//   }
//   bool? _ischecked = true;
//   Widget _checkboxagreement(bool isloginbol){
//     return (!isloginbol ? (Center(
//       child: CheckboxListTile(
//         title: const Text("I agree to Labelit's terms and conditions"),
//         value: _ischecked,
        
//         // tristate: true,
//         onChanged: (newvalue){
//           setState(() {
//             _ischecked = newvalue;
//           });
//         },
//         activeColor: Colors.blue,
//         checkColor: Colors.white,
//         // tileColor: Colors.black12,
//         controlAffinity: ListTileControlAffinity.leading,
//       ),
//     )): Center());
//   }

//   // Widget _submitButton() {
//   //   return ElevatedButton(
//   //     onPressed:
//   //       createUserWithEmailAndPassword,
//   //     child: Text(
//   //       'Signup',
//   //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//   //       ),
//   //     style: ElevatedButton.styleFrom(
//   //       shape: RoundedRectangleBorder( //to set border radius to button
//   //               borderRadius: BorderRadius.circular(16)
//   //           ),
//   //           padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
//   //     ),
//   //   );
//   // }
//   Widget _submitButton() {
//     return ElevatedButton(
//       onPressed:
//           isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,  
//       child: Text(
//         isLogin ? 'Login' : 'Signup',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder( //to set border radius to button
//                 borderRadius: BorderRadius.circular(16)
//               ),
//         backgroundColor: Color.fromRGBO(51, 103, 171, 1),
//         padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
//       ),
//     );
//   }

//   // Widget _loginOrRegisterButton() {
//   //   return TextButton(
//   //     onPressed: () {
//   //       setState(() {
//   //         isLogin = !isLogin;
//   //       });
//   //     },
//   //     child: Text(isLogin ? 'Register instead' : 'Login instead'),
//   //   );
//   // }
//   Widget _dontHaveAccount(){
//       return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           isLogin? "Don't have an account? ":"Already have account? ",
//           style: TextStyle(color: Colors.black),
//           ),
//         GestureDetector(
//           onTap: (){
//             setState(() {
//               isLogin = !isLogin;
//             });
//           },
//           child: Text(
//             isLogin? "Signup" : "Login",
//             style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget _dontHaveAccount(){
//   //   return TextButton(
//   //     onPressed: (){},
//   //     child: Text("Don't have account?"),
//   //   );
//   // }
//   // Widget _dontHaveAccount(){
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     children: [
//   //       const Text(
//   //         "Already have account? ",
//   //         style: TextStyle(color: Colors.black),
//   //         ),
//   //       GestureDetector(
//   //         onTap: (){
//   //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
//   //         },
//   //         child: const Text(
//   //           "Login",
//   //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       // backgroundColor: Colors.grey[200],
//       // appBar: AppBar(
//       //   title: _title(),
//       // ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
//             child: Column(
//               children: <Widget>[
//                 Center(
//                   child: _img(),
//                 ),
//                   SizedBox(height: 30,),
//                   Text(
//                     isLogin? "Login":"Signup",
//                     style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold),
//                     ),
//                 _entryField('Email', _controllerEmail),
//                 _entryField('Password', _controllerPassword),
//                 SizedBox(height: 10,),
//                 _forgetpass(isLogin),
//                 _errorMessage(),
//                 _checkboxagreement(isLogin),
//                 _submitButton(),
//                 SizedBox(height: 10,),
//                 _dontHaveAccount()
//               ]
//               ),
//           ),
//       ),
//       ),
      
//     );
//   }
// }
