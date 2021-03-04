import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/ios_search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IOSSearchBar(
              controller: _searchTextController,
              focusNode: _searchFocusNode,
              animation: _animation,
              onCancel: _cancelSearch,
              onClear: _clearSearch,
            )
          ),
        ),
      ],
    );
  }
}
