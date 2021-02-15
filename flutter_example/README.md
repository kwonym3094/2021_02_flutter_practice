# flutter 보면서 배운 것들

Widget : Android 의 View 와 비슷한 개념
 - 차이점
   * immutable
   * 변해야 하기 전까지 존재함 (android 의 life cycle 과 같지 않음)

- StatelessWidget : 아무것도 변하지 않을 때 사용하기 좋음 (ex. logo image)
- StatefulWidget : 통신, UI에 따라 변해야 할 때 사용하기 좋음
  -> 사실은 StatelessWidget 와 동작이 같으나 안에 있는 State 객체가 변함

layout은 어디에 적나?
  - 따로 xml 없음
  - widget tree 라고 하는 양식을 따라 작성
  ex)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: 20.0, right: 30.0),
          ),
          onPressed: () {},
          child: Text('Hello'),
        ),
      ),
    );
  }

Scaffold : default app 화면
