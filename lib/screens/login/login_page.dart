import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/login/sign_up.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "123@gmail.com", _password = "123456";

  // void _submit() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState?.save();
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: _email, password: _password);
  //       // print('User signed in: ${userCredential.user.uid}');
  //       onGetStartedClicked(context);
  //     } catch (e) {
  //       print('Error signing in: $e');
  //     }
  //   }
  // }

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
              SizedBox(
                height: 20,
              ),
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
                    : null,
                onSaved: (input) => _email = input.toString(),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                validator: (input) => input != null
                    ? input.length < 6
                        ? 'Password must be at least 6 characters'
                        : null
                    : null,
                onSaved: (input) => _password = input.toString(),
                obscureText: true,
              ),
              SizedBox(height: 20),
              getButton(context),
              SizedBox(
                height: 20,
              ),
              getRegisterButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return DashboardScreen();
      },
    ));
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Login",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          _formKey.currentState?.save();
          try {
            print(_password);
            final user = await _auth.signInWithEmailAndPassword(
                email: _email, password: _password);
            if (user != null) {
              print(user);
              onGetStartedClicked(context);
            }
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }

  Widget getRegisterButton(BuildContext context) {
    return AppButton(
      label: "Register",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onGetLoginClicked(context);
      },
    );
  }

  void onGetLoginClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return RegistrationPage();
      },
    ));
  }

  Widget splashScreenIcon() {
    String iconPath = "assets/icons/logo.svg";
    return SvgPicture.asset(
      iconPath,
    );
  }
}
