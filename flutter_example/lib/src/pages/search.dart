import 'package:flutter/material.dart';
import 'package:flutter_example/src/components/video_widget.dart';
import 'package:flutter_example/src/controller/youtube_search_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class YoutubeSearch extends GetView<YoutubeSearchController> {
  Widget _searchHistory() {
    return ListView(
        children: List.generate(
            controller.history.length,
            (index) => ListTile(
                  onTap: () {
                    controller.search(controller.history[index]);
                  },
                  leading: SvgPicture.asset(
                    "assets/svg/icons/wall-clock.svg",
                    width: 20,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(controller.history[index]),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                )).toList());
  }

  Widget _searchResultView() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
          children: List.generate(
              controller.youtubeVideoResult.value.items.length, (index) {
        return GestureDetector(
          child: VideoWidget(
            video: controller.youtubeVideoResult.value.items[index],
          ),
          onTap: () {
            Get.toNamed(
                '/detail/${controller.youtubeVideoResult.value.items[index].id.videoId}');
          },
        );
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.find<YoutubeSearchController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/svg/icons/back.svg"),
          onPressed: Get.back,
        ),
        title: TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey.withOpacity(0.2),
            filled: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(5)),
          ),
          onSubmitted: (value) {
            controller.search(value);
          },
        ),
      ),
      body: Obx(
        () => controller.youtubeVideoResult.value.items.length > 0
            ? _searchResultView()
            : _searchHistory(),
      ),
    );
  }
}
