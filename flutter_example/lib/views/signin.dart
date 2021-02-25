import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/helper/helperfunctions.dart';
import 'package:flutter_example/services/auth.dart';
import 'package:flutter_example/services/database.dart';
import 'package:flutter_example/views/chatroom_screen.dart';
import 'package:flutter_example/widget/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  // Future 객체를 받기 위해서 선언
  QuerySnapshot snapshotUserInfo;

  TextEditingController emailTextEditingController;
  TextEditingController passwordTextEditingController;

  bool isLoading = false;


  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  signIn() {
    if (formKey.currentState.validate()) {

      HelperFunctions.saveUserEmail(emailTextEditingController.text);


      print('id searching ...');
      databaseMethods.getUserByEmail(emailTextEditingController.text)
          .then((val) {
            print('searching');
            print('$val');
        snapshotUserInfo = val;
        HelperFunctions.saveUserName(snapshotUserInfo.docs[0].data()['name']);
      });
      print('ending');

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {

            if (val != null) {
              HelperFunctions.saveLogIn(true);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom() ));

            }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextEditingController,
                      style: simpleTestStyle(),
                      decoration: textFieldInputDecoration('email'),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please provide a valid email";
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordTextEditingController,
                      style: simpleTestStyle(),
                      decoration: textFieldInputDecoration('password'),
                      validator: (val) {
                        return val.length > 6
                            ? null
                            : "Please provide password 6+ character";
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Forgot password?",
                    style: simpleTestStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: mainButton(context, "Sign In", Color(0xff2A75BC))),
              SizedBox(
                height: 8,
              ),
              mainButton(context, "Sign In With Google", Colors.white,
                  textColor: Colors.black),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account? ",
                    style: mediumTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () => {widget.toggle()},
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle simpleTestStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

Container mainButton(BuildContext context, String text, Color bgColor,
    {Color textColor = Colors.white}) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration:
        BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(30)),
    child: Text(
      text,
      style: TextStyle(color: textColor),
    ),
  );
}
