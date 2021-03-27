import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/card_horizontal.dart';
import 'package:flutter_example/widget/header.dart';
import 'package:flutter_example/models/categoreis.dart';

class MainPage extends StatelessWidget {
  List<Categories> categories = [
    Categories(title: "웨이트 트레이닝", color: Color(0xffF7D6AD)),
    Categories(title: "요가", color: Color(0xffFF7BB1)),
    Categories(title: "필라테스", color: Color(0xffFE2203)),
  ];

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
              Row(
                children: [
                  Expanded(
                    child: Header(
                      title: "내 라이브러리",
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10), child: Text("더보기"))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              HorizontalCardsView(),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Header(
                      title: "추천 프로그램",
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10), child: Text("더보기"))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              HorizontalCardsView(),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Header(
                      title: "카테고리",
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10), child: Text("더보기"))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 350,
              )
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
