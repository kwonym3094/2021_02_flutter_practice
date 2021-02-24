import 'package:flutter/material.dart';
import 'package:flutter_example/views/spec.dart';
import 'package:flutter_example/widget/buttonstyle.dart';
import 'package:flutter_example/widget/textstyle.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50,),
            TextField(
              style: TextStyle(color: Colors.white,),
              decoration: textFieldInputDecoration("email"),
            ),
            TextField(
              style: TextStyle(color: Colors.white,),
              decoration: textFieldInputDecoration("password"),
            ),
            SizedBox(height: 8,),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Forgot password? ", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 8,),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SpecPage()));
                },
                child: MainButton(context, "Sign In", Colors.white, Colors.blue)),
            SizedBox(height: 8,),
            MainButton(context, "Sign In with Google", Colors.black, Colors.white),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                    child: Text("Register now.", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),)),
              ],
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}