## Bloc 패턴이란
 - **B**ussiness
 - **Lo**gic
 - **c**omponent
 - UI 부분은 비즈니스 로직과 상관없이 받은 데이터만 보여주면 된다는 아이디어
 - ![bloc pattern](https://i0.wp.com/everyday.codes/wp-content/uploads/2020/06/bloc-splash.png?fit=925%2C455&ssl=1)
 - UI 위젯에서는 이벤트만 넘겨주고 모든 변경은 Bloc 에서 처리
 - bloc을 구독하고 있는 UI에 Stream 으로 넘겨줌
 
## bloc 패턴이어야 하는 이유
 - 기본 widget : StatelessWidget, StatefulWidget
 - 기본 widget에서의 문제
    * 서버로 부터 데이터를 받아오거나, 로컬파일을 비지니스로직에 따라 복잡한 widget 트리에 정보를 변경하는 것은 StatefulWidget 에서 어려움
    * 복잡한 트리 구조에서 tree 의 뿌리 부분에 setState를 지정해준다하면 tree 의 모든 widget을 다시 build 해줘야함 >> 성능 문제
    * 트리 중 하나의 widget 에 하위 widget 을 추가한다면 상단의 모든 widget 을 변경해줘야하는 번거로움이 생김
 - 비즈니스 로직과 UI를 떨어트려놓고 필요에따라 원하는 부분만 UPDATE 처리할 수 있음

## Bloc 기본 패턴
 - Bloc (class)
 - EventBloc (class)
 - Event (enum)

## bloc 패턴의 단점
 - bloc 파일들이 많아짐
 - 이해하고 사용하는데 진입장벽이 큼
 
 => 이를 해결하기 위해 나온것이 provider
 
 
 ## GetxController vs GetService
  - GetxController는 permanent: true 인자를 넣어 controller가 메모리에 계속 남아있게 할 수 있고
  - GetService역시 계속 남아있게 할 수 있지만, 필요한 경우 Get.reset()으로 메모리의 모든 instance를 내릴 수 있음 (모든! 인스턴스를 내리니 사용에 주의)
