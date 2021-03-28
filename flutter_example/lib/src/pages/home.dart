import 'package:flutter/material.dart';
import 'package:flutter_example/src/components/custom_app_bar.dart';
import 'package:flutter_example/src/components/video_widget.dart';
import 'package:flutter_example/src/controller/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              title: CustomAppBar(),
              floating: true,
              snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    child: VideoWidget(
                      video: controller.youtubeResult.value.items[index],
                    ),
                    onTap: () {
                      Get.toNamed(
                          '/detail/${controller.youtubeResult.value.items[index].id.videoId}');
                    },
                  );
                },
                childCount: controller.youtubeResult.value.items == null
                    ? 0
                    : controller.youtubeResult.value.items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
