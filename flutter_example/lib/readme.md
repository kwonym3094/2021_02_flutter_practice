### 따라가야할 로직

1. Validated Value Object 만들기
 - 항상 make illegal states unrepresentable 의 원칙을 기억
 - failure 이 생길만한 케이스 고려

2. BloC과 Validated Value Object 혹은 Infrastructure을 연결할 수 있는 Interface 만들기
 - interface 할 때 infrastructure에서 생길만한 오류 고려하여 failure class 만들어주기 (ex. 로그인 실패 시 오류 등등)

3. Application에 Bloc 만들기

4. infrastructure 에서 통신하는 로직 만들어주기
    - dependency injection 고려

5. UI 구현


### 알아야할 패키지 내부 정보들

 - Unit : dartz 패키지의 자료형. void 와 같은 의미(dart 자체에서는 void를 자료형으로 사용할 수 없기 때문)