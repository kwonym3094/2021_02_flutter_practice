import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/helper/constants.dart';
import 'package:flutter_example/helper/helperfunctions.dart';
import 'package:flutter_example/services/database.dart';
import 'package:flutter_example/views/conversation-screen.dart';
import 'package:flutter_example/views/signin.dart';
import 'package:flutter_example/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName ;

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTextEditingController =
      new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  // create chatroom, send user to conversation screen, push replacement
  createChatroomAndStartConversation({String userName}){

    print("testing ${Constants.myName}");
    if (userName != Constants.myName) {
      List<String> users = [userName, Constants.myName];

      String chatRoomId = getChatRoomId(userName, Constants.myName);

      Map<String, dynamic> chatRoomMap = {
        'users' : users,
        'chatroomId' : chatRoomId
      };

      DatabaseMethods().createChatroom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {
      print("you cannot send message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // should not be predefined !
              Text(
                userName,
                style: mediumTextStyle(),
              ),
              Text(
                userEmail,
                style: mediumTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(
                userName: userName,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text("Message", style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.docs[index].data()["name"],
                userEmail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }


  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    _myName = await HelperFunctions.getUserName();
    setState(() {

    });
    print("$_myName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
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
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}


// chatroom 구성은 같지만 chatroom id 의 순서가 바뀌어 다른 아이디가 되지 않게 처리
getChatRoomId(String a, String b){
  if (a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}