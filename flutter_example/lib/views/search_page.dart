
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/override_search_bar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar(),
        // child: SearchBar<Post>(
        //   onSearch: search,
        //   onItemFound: (Post post, int index) {
        //     return ListTile(
        //       title: Text(post.title),
        //       subtitle: Text(post.description),
        //     );
        //   },
        //   searchBarStyle: SearchBarStyle(
        //     borderRadius: BorderRadius.circular(8),
        //     backgroundColor: Colors.grey[300]
        //   ),
        //   minimumChars: 1,
        //   debounceDuration: Duration(milliseconds: 20),
        // ),
      ),
    );
  }
}


