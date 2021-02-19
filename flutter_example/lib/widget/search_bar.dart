import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  bool _isFocused = false;
  bool _isEdited = false;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(5.0,5.0),
            blurRadius: 5.0,
            color: Colors.black87.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Icons.search,
              size: 18,),
          ),
          Flexible(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration.collapsed(hintText: "Search"),
              onChanged: (text) {
                _toggleClearButton(text);
              },
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("return test"),
                      content: Text("$value"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'))
                      ],

                    );
                  }
                );
              },
            ),
          ),
          _isEdited? IconButton(
            icon: Icon(CupertinoIcons.clear, size: 15,),
            onPressed: _handleClearButton,
            iconSize: 6,
          ) : Container(),
        ],
      ),
    );
  }

  void _toggleClearButton(String text) {
    setState(() {
      if (text.length > 0) {
        _isEdited = true;
      } else {
        _isEdited = false;
      }
    });
  }

  void _handleClearButton() {
    setState(() {
      _textEditingController.text = "";
    });
  }
}

class _ClearButton extends StatefulWidget {

  final bool active;
  final ValueChanged<bool> onChanged;

  _ClearButton({Key key, this.active, this.onChanged}):super(key: key);

  @override
  __ClearButtonState createState() => __ClearButtonState();
}

class __ClearButtonState extends State<_ClearButton> {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.clear);
  }
}


