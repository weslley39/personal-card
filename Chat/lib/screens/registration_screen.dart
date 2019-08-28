import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/ButtonRounded.dart';
import 'package:flash_chat/components/InputRounded.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _authService = FirebaseAuth.instance;

  String email;
  String password;
  bool isLoading = false;

  void doRegister() async {
    try {
      setState(() {
        isLoading = true;
      });
      final newUser = await _authService.createUserWithEmailAndPassword(
          email: this.email, password: this.password);
      if (newUser != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: this.isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputRounded(
                type: TextInputType.emailAddress,
                hint: 'Enter your email',
                onChange: (value) {
                  this.email = value;
                },
              ),
              SizedBox(height: 8.0),
              InputRounded(
                isObscure: true,
                hint: 'Enter your password',
                onChange: (value) {
                  this.password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonRounded(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  this.doRegister();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
