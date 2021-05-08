## infrastructure layer

- Exception 을 Failure로 변환하는 역할
- 데이터가 제대로 넘어온다면 도메인에게 전달하는 interface 역할
- core
    - injectable 
        - 3rd party library는 annotation을 할 수 없기 때문에 abstract class 를 만들어 이를 annotation 함
        - FirebaseAuth 와 GoogleSignIn 만 module화 했는데 왜 infrastructure/auth 에 넣지 않고 infrastructure/core 에 넣었는가?
            - 단순히 몇개의 properties를 만드는 것이라면, 확장성을 고려해 core에 넣는게 더 유효함