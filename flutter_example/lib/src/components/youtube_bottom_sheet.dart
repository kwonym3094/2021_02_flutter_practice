import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class YoutubeBottomSheet extends StatelessWidget {
  Widget _header() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        '만들기',
        style: TextStyle(fontSize: 16),
      ),
      IconButton(
        icon: Icon(Icons.close),
        onPressed: Get.back,
      )
    ]);
  }

  Widget _itemButton(
      {String icon, double iconSize, String label, Function onTap}) {
    InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            child: SvgPicture.asset('assets/svg/icons/$icon'),
          ),
          SizedBox(
            width: 15,
          ),
          Text(label)
        ],
      ),
    ); // 제스처 디텍터랑 비슷한 듯
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        height: 200,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            _header(),
            SizedBox(
              height: 10,
            ),
            _itemButton(
              icon: 'upload.svg',
              iconSize: 17,
              label: "동영상업로드",
              onTap: () {
                print("동영상 업로드 기능");
              },
            ),
            _itemButton(
              icon: 'upload.svg',
              iconSize: 17,
              label: "동영상업로드",
              onTap: () {
                print("동영상 업로드 기능");
              },
            )
          ],
        ),
      ),
    );
  }
}
