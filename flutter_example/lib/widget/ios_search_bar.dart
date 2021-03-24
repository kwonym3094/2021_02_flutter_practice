import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSSearchBar extends AnimatedWidget {
  IOSSearchBar({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);
  
  final TextEditingController controller;
  
  final FocusNode focusNode;
  
  final Function onCancel;

  final Function onClear;
  
  final Function(String) onUpdate;
  
  final Function(String) onSubmit;

  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _kFontSize = 13.0;

  @override
  Widget build(BuildContext context) {

    final Animation<double> animation = listenable;

    return Material(
      child: Row(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              border: Border.all(width: 0.0, color: CupertinoColors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.inactiveGray,
                      size: _kFontSize + 2.0,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        height: _kFontSize + 15.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: 'Search',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          controller: controller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                          autocorrect: false,
                          focusNode: focusNode,
                          onChanged: onUpdate,
                          onSubmitted: onSubmit,
                          cursorColor: CupertinoColors.black,
                        ),
                      ),
                  ),
                  CupertinoButton(
                    minSize: 10.0,
                    padding: const EdgeInsets.all(1.0),
                    borderRadius: BorderRadius.circular(30.0),
                    color: CupertinoColors.inactiveGray.withOpacity(
                      1.0 - _opacityTween.evaluate(animation),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 15.0,
                      color: CupertinoColors.systemGrey5,
                    ),
                    onPressed: () {
                      if (animation.isDismissed) return ;
                      else onClear();
                    },
                  )
                ],
              ),
            ],),
          ),
        ),
        SizedBox(
          width: _paddingTween.evaluate(animation),
          child: CupertinoButton(
            padding: const EdgeInsets.only(left: 8.0),
            onPressed: onCancel,
            child: Text('Cancel',
            softWrap: false,
            style: TextStyle(
              inherit: false,
              color: CupertinoColors.black,
              fontSize: _kFontSize,
            ),),
          ),
        )
      ],),
    );
  }
  
}
