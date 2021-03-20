import 'package:flutter/material.dart';
import 'package:flutter_example/src/components/custom_app_bar.dart';
import 'package:flutter_example/src/components/video_widget.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: CustomAppBar(),
          floating: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return GestureDetector(
              child: VideoWidget(),
              onTap: () {
                Get.toNamed('/detail/21656');
              },
            );
          }, childCount: 10),
        )
      ],
    ));
  }
}
