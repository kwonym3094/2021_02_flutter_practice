import 'package:flutter/material.dart';
import 'package:flutter_example/widget/widget.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Widget ChatMessageList () {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none),
                        )),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/send.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
