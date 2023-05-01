// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _email, _password;

//   void _submit() async {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(
//                 email: _email, password: _password);
//         print('User signed in: ${userCredential.user.uid}');
//       } catch (e) {
//         print('Error signing in: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       body: Padding(
//         padding: const EdgeInsets.all(36.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(hintText: 'Email'),
//                 validator: (input) =>
//                     !input.contains('@') ? 'Please enter a valid email' : null,
//                 onSaved: (input) => _email = input,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(hintText: 'Password'),
//                 validator: (input) =>
//                     input.length < 6
//                         ? 'Password must be at least 6 characters'
//                         : null,
//                 onSaved: (input) => _password = input,
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               RaisedButton(
//                 onPressed: _submit,
//                 child: Text('Login'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
