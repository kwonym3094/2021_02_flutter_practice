# flutter 보면서 배운 것들

1. Widget : Android 의 View 와 비슷한 개념
 - 차이점
   * immutable
   * 변해야 하기 전까지 존재함 (android 의 life cycle 과 같지 않음)

- StatelessWidget : 아무것도 변하지 않을 때 사용하기 좋음 (ex. logo image)
- StatefulWidget : 통신, UI에 따라 변해야 할 때 사용하기 좋음
  -> 사실은 StatelessWidget 와 동작이 같으나 안에 있는 State 객체가 변함

2. layout은 어디에 적나?
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

3. Scaffold : default android app 화면 (material design)

4. Container : padding, margin, border, background color 설정하기 위해 사용
 - padding: EdgeInsets.fromLTRB(20, 30, 20, 20), << 이런 방식

5. Expanded : 화면 사이즈 맞추기
  - (property) flex : 크기 비율 설정하는 property 
6. mainAxisAlignment, crossAxisAlignment : 축 진행 방향에 따라 달라지는 것 잘 이해하기

7. 반응형 앱 만들기 위해 flutter에서 권고하는 사항
    1) LayoutBuilder 클래스 사용
    2) build function 안에서 MediaQuery.of() 메소드 사용
    - 참고 https://flutter.dev/docs/development/ui/layout/responsive

!!!!!
8. Stateful Widget : non-interactive 한 widget 을 interactive 하게 만들어줌