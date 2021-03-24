import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/card_horizontal.dart';
import 'package:flutter_example/widget/content_list_widget.dart';
import 'package:flutter_example/widget/header.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Header(
                title: "My Workouts",
              ),
              SizedBox(
                height: 40,
              ),
              HorizontalCardsView(),
              SizedBox(
                height: 40,
              ),
              Header(
                title: "Other lists",
              ),
              SizedBox(
                height: 8,
              ),
              HorizontalCardsView(),
            ],
          ),
        )
      ],
    );
  }
}

// horizontal sliding 카드 뭉치
class HorizontalCardsView extends StatefulWidget {
  @override
  _HorizontalCardsViewState createState() => _HorizontalCardsViewState();
}

class _HorizontalCardsViewState extends State<HorizontalCardsView> {
  // 페이지 끝에 다음 카드 보이는 효과를 위한 컨트롤러 생성
  PageController pageController;

  // parallax 효과(animation)를 위한 변수
  double pageOffset = 0;

  // 다음 두 개 메소드를 override 해서 충돌 막음
  @override
  void initState() {
    super.initState();
    pageController = PageController(
        viewportFraction: 0.7); // viewportFraction << 다음 카드가 살짝 보일 수 있게 하는 것
    // parallax 효과를 위해 추가
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: [
          SlidingCard(
            name: 'Shenzhen Global Design Award 2018',
            date: '4.20 - 30',
            assetName: 'pattern1.jpg',
            offset: pageOffset,
          ),
          SlidingCard(
            name: 'Academy Award CA 2018',
            date: '5.20 - 30',
            assetName: 'pattern2.jpg',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            name: 'Gramy Award NY 2018',
            date: '6.20 - 30',
            assetName: 'pattern3.jpg',
            offset: pageOffset - 2,
          ),
        ],
      ),
    );
  }
}
