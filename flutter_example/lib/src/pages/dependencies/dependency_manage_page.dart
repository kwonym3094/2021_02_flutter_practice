import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/dependency_controller.dart';
import 'package:flutter_example/src/pages/dependencies/get_lazy_put.dart';
import 'package:flutter_example/src/pages/dependencies/get_put.dart';
import 'package:get/get.dart';

class DependencyManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("의존성 주입"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Get.put"),
              onPressed: () {
                Get.to(() => GetPutPage(),
                    // binding이라는 것을 함 (추후에 설명함)
                    // 페이지로 보내주면서 사용할 컨트롤러를 주입하는 방식
                    binding: BindingsBuilder(() {
                  Get.put(
                      DependencyController()); // 페이지를 넘어갈 때 바인딩을 해줌. 전과 다른 페이지 라우팅 하는 단계에서 바인딩.
                  // 인스턴스가 쌓이게 되면 애플리케이션이 점점 느려지기 때문에 메모리 관리가 중요한데
                  // 더이상 사용하지 않을 때 자동으로 삭제되기 때문에 관리에 용이함
                }));
              },
            ),
            RaisedButton(
              child: Text("Get.lazyPut"),
              onPressed: () {
                Get.to(() => GetLazyPutPage(), binding: BindingsBuilder(() {
                  Get.lazyPut<DependencyController>(() =>
                      DependencyController()); // 예상 가능하게 사용할 때 메모리에 올라가게 됨
                }));
              },
            ),
            RaisedButton(
              child: Text("Get.putAsync"), // 비동기처리해주고 put 한다는 의미
              onPressed: () {
                Get.to(() => GetPutPage(), binding: BindingsBuilder(() {
                  Get.putAsync<DependencyController>(() async {
                    await Future.delayed(Duration(seconds: 5));
                    return DependencyController(); // 아무 기능이 없을 때는 put과 같음. put으로 접근할 때 데이터 받아온 이후에 controller를 instance 화 해야할 때 사용
                  });
                }));
              },
            ), // -------------- 이까지의 방식은 singletone 방식 (= 하나만 존재함, 그것을 공유)
            // 다음 방식은 instance가 여러 개 만들어짐 (쓸일이 거의 없었음)
            RaisedButton(
              child: Text("Get.create"),
              onPressed: () {
                Get.to(() => GetPutPage(), binding: BindingsBuilder(() {
                  Get.create<DependencyController>(
                      () => DependencyController());
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
