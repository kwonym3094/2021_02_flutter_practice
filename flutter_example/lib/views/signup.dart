import 'package:flutter/material.dart';
import 'package:flutter_example/services/auth.dart';
import 'package:flutter_example/services/database.dart';
import 'package:flutter_example/views/signin.dart';
import 'package:flutter_example/widget/widget.dart';

import 'chatroom_screen.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  // 로그인 검증
  AuthMethods authMethods = new AuthMethods();

  // 데이터 저장하기 위한 모듈
  DatabaseMethods databaseMethods = new DatabaseMethods();

  // form validation 을 위한 key
  final formKey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController;
  TextEditingController emailTextEditingController;
  TextEditingController passwordTextEditingController;

  // loading option
  signMeUp() {
    if (formKey.currentState.validate()) {

      Map<String,Object> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text
      };

      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val) {
        print('${val}');


        databaseMethods.uploadUserInfo(userInfoMap);

        // pushReplacement() << 이전 화면으로 못 돌아가게 하는 기능
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder : (context) => ChatRoom()
        ));
          });
    }
  }

  @override
  void initState() {
    super.initState();
    userNameTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    userNameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        // 같이 validating 해주기 위해서 묶음
                        // form 안에서 key가 발급 되기 때문에 그 key로 validation check
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 2
                                  ? "Please Provide a valid username"
                                  : null;
                            },
                            controller: userNameTextEditingController,
                            style: simpleTestStyle(),
                            decoration: textFieldInputDecoration("username"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please provide a valid email";
                            },
                            controller: emailTextEditingController,
                            style: simpleTestStyle(),
                            decoration: textFieldInputDecoration("email"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Please provide password 6+ character";
                            },
                            controller: passwordTextEditingController,
                            style: simpleTestStyle(),
                            decoration: textFieldInputDecoration("password"),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          signMeUp();
                        },
                        child:
                            mainButton(context, "Sign Up", Color(0xff2A75BC))),
                    SizedBox(
                      height: 8,
                    ),
                    mainButton(context, "Sign Up With Google", Colors.white,
                        textColor: Colors.black),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: mediumTextStyle(),
                        ),
                        GestureDetector(
                          onTap: (){
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Sign in now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
