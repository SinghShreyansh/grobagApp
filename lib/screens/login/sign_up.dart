import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/login/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              splashScreenIcon(),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: (input) => input != null
                    ? input.contains('@')
                        ? null
                        : 'Please enter a valid email'
                    : 'Please enter your email',
                onSaved: (input) => _email = input.toString(),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                validator: (input) => input != null
                    ? input.length < 6
                        ? 'Password must be at least 6 characters'
                        : null
                    : 'Please enter your password',
                onSaved: (input) => _password = input.toString(),
                obscureText: true,
              ),
              SizedBox(height: 20),
              getButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginPage();
      },
    ));
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Register",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          _formKey.currentState?.save();
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password);
            // print('User signed up: ${userCredential.user.uid}');
            onGetStartedClicked(context);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print('Error signing up: $e');
          }
        }
      },
    );
  }

  Widget splashScreenIcon() {
    String iconPath = "assets/icons/logo.svg";
    return SvgPicture.asset(
      iconPath,
    );
  }
}
