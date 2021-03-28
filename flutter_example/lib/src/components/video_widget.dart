import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/controller/video_controller.dart';
import 'package:flutter_example/src/models/video.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // data formatting 을 위한 라이브러리

class VideoWidget extends StatefulWidget {
  final Video video;

  const VideoWidget({Key key, this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoController _videoController;
  @override
  void initState() {
    // Get.put(VideoController()); // 인스턴스가 하나가 됨 << 개별적인 데이터 컨트롤할수가 없음
    _videoController = Get.put(VideoController(video: widget.video),
        tag: widget.video.id.videoId);
    super.initState();
  }

  Widget _thumbnail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.grey.withOpacity(0.5),
          // 한꺼번에 controller를 다 불러오는것을 막기 위해 cached_network_image 사용
          // child: Image.network(
          //   widget.video.snippet.thumbnails.medium.url,
          //   fit: BoxFit.fitWidth,
          // ),
          child: CachedNetworkImage(
            imageUrl: widget.video.snippet.thumbnails.medium.url,
            placeholder: (context, url) => Container(
              height: 230,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 15),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage:
                  Image.network(_videoController.youtuberThumbnailUrl).image,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.video.snippet.title,
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(Icons.more_vert),
                      iconSize: 18,
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.video.snippet.channelTitle,
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.8)),
                    ),
                    Text(" . "),
                    Obx(
                      () => Text(
                        _videoController.viewCountString,
                        // "조회수: ${_videoController.statistics.value.viewCount}회", // 이 방법보다 위의 방법
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Text(" . "),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(widget.video.snippet.publishTime),
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }
}
