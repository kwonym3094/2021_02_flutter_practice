# flutter 보면서 배운 것들

1. Widget : Android 의 View 와 비슷한 개념
 - 차이점
   * immutable
   * 변해야 하기 전까지 존재함 (android 의 life cycle 과 같지 않음)

 - StatelessWidget : 아무것도 변하지 않을 때 사용하기 좋음 (ex. logo image, icon button, text ...)
 - StatefulWidget : 사용자와 상호작용(터치, 스와이프, 통신 등)에 따라 변해야 할 때 사용 (ex. checkbox, radio, slider, inkwell, form, text field)
  -> 사실은 StatelessWidget 와 동작이 같으나 안에 있는 State 객체가 변함
  -> State 객체에 위젯의 상태가 저장됨
  -> State는 변할 수 있는 values 들로 구성됨
  -> 위젯의 상태가 변할때 setState()를 call 하게 됨
  -> setState()는 프레임워크에 위젯의 state가 변했으니 다시 그리라고 알려줌
  -> State class 안에 변할 수 있는 데이터를 담게 됨 ex. bool _isFavorited = true; int _favoriteCount = 41;

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

9. IconButton 과 Icon의 차이 : IconButton 은 onPressed 라는 callback function 가지고 있음

10. SizedBox 안에 Text를 넣으면 State 변할 때 값이 제대로 변하지 않는 것을 방지할 수 있음

11. state 관리는 어떻게 해야하는가?
 - 3가지 방법 있음
  * 위젯이 스스로의 state 관리
  * 부모가 위젯의 state 관리
  * 믹스 앤 매치 : stateful widget 자체가 몇개의 state를 관리하고 부모가 몇개의 state를 관리
 - 심미적인 부분(애니메이션 등등)에 관련된 것은 위젯이 스스로 관리
 - 사용자 데이터와 관련된 것(체크박스, 슬라이더 위치) 등은 부모가 관리
 
12. 플러터에서는 screen 이나 page 를 route 라고 부름
13. 이 route 간 이동할 수 있게 만들어 주는 것 -> navigator