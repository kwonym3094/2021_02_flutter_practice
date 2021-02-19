import 'package:flutter/material.dart';
import 'package:flutter_example/widget/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                style: simpleTestStyle(),
                decoration: textFieldInputDecoration('email')),
            TextField(
              style: simpleTestStyle(),
              decoration: textFieldInputDecoration('password'),
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
            mainButton(context, "Sign In", Color(0xff2A75BC)),
            SizedBox(height: 8,),
            mainButton(context, "Sign In With Google", Colors.white, textColor: Colors.black),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account? ", style: mediumTestStyle(),),
                Text("Register now", style: TextStyle(color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),),
              ],
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}

TextStyle simpleTestStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumTestStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

Container mainButton(BuildContext context, String text, Color bgColor,
    {Color textColor = Colors.white}) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30)),
    child: Text(
      text,
      style: TextStyle(color: textColor),
    ),
  );
}
