import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

// horizontal sliding 단일 카드

class SlidingCard extends StatelessWidget {
  final double offset; //<-- 얼마나 페이지가 멀리 위치하는지 나타냄
  final String name; //<-- 제목
  final String date; //<-- 날짜
  final String assetName; //<-- 이미지

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // gauss function 그래프에 맞춰서 움직이게 만듬
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5),2) / 0.08));

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Container(
        child: Card(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          //<--custom shape
          child: Column(
            children: <Widget>[
              ClipRRect(
                //<--clipping image
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.asset(
                  //<-- main image
                  'images/$assetName',
                  height: MediaQuery.of(context).size.height * 0.25,
                  // width: MediaQuery.of(context).size.width,
                  fit: BoxFit.none,
                  // parallax : index에 따라 alignment 바꿈
                  // 이미지 크기가 상대적으로 더 클 때는 매우 산만하게 되어 주석처리
                  // alignment: Alignment(-offset.abs(), 0),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  name: name,
                  date: date,
                  offset: gauss,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent({Key key, @required this.name, @required this.date, @required this.offset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(10 * offset, 0), //<<-- 이동
            child: Text(name, style: TextStyle(fontSize: 20))
          ),
          SizedBox(
            height: 6,
          ),
          Transform.translate(
            offset: Offset(20 * offset, 0), //<<-- 이동
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Transform.translate(
                offset: Offset(20 * offset, 0), //<<-- 이동
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '0.00',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(20 * offset, 0), //<<-- 이동
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: RaisedButton(
                    color: Color(0xFF162A49),
                    child: Text('Start'),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
