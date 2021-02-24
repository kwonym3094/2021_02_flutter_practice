import 'package:flutter/material.dart';
import 'package:flutter_example/widget/buttonstyle.dart';
import 'package:flutter_example/widget/textstyle.dart';



class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userNameTextEditingController;
  TextEditingController emailTextEditingController;
  TextEditingController passwordTextEditingController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void SignMeUp(){
    if (formKey.currentState.validate()) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50,),
              TextFormField(
                validator: (val) {
                  return val.isEmpty || val.length < 2 ? "Please provide a valid username" : null;
                },
                controller: userNameTextEditingController,
                style: TextStyle(color: Colors.white,),
                decoration: textFieldInputDecoration("name"),
              ),
              TextFormField(
                validator: (val) {
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)
                      ? null
                      : "Please provide a valid email" ;
                },
                controller: emailTextEditingController,
                style: TextStyle(color: Colors.white,),
                decoration: textFieldInputDecoration("email"),
              ),
              TextFormField(
                validator: (val) {
                  return val.length > 6 ? null : "Please provide password 6+ character" ;
                },
                controller: passwordTextEditingController,
                style: TextStyle(color: Colors.white,),
                decoration: textFieldInputDecoration("password"),
              ),
              SizedBox(height: 8,),
              GestureDetector(
              onTap: () {
                SignMeUp();
              },
                  child: MainButton(context, "Sign Up", Colors.white, Colors.blue)),
              SizedBox(height: 8,),
              MainButton(context, "Sign Up with Google", Colors.black, Colors.white),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: Colors.white),),
                  GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Text("Sign in now.", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),)),
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}